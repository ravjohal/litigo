# module ScaledJob
#   def after_enqueue_scale_workers(*args)
#     Rails.logger.info "Scaling worker count up"
#     Scaler.up! if Redis.info[:pending].to_i > 25
#   end
# end

module LoggedJob
  def before_perform_log_job(*args)
    Rails.logger.info "About to perform #{self} with #{args.inspect}"
  end
end

module RetriedJob
  def on_failure_retry(e, *args)
    Rails.logger.info "Performing #{self} caused an exception (#{e}). Retrying..."
    Resque.enqueue self, *args
  end
end


class SyncCalendar
  extend LoggedJob
  extend RetriedJob
  # extend ScaledJob

	@queue = :calendar

	def self.perform(params_)
		params_ = params_.symbolize_keys

		puts "PARAMS ---------------------> " + params_.inspect

		namespace = Namespace.find(params_[:namespace_id])
	    sync_period = params_[:sync_period].to_i
	    user = User.find(params_[:user_id]) #.includes[:firm]
	    firm = user.firm

	    user_calendars = user.calendars

	    puts " CALENDARS ----------------------> " + user_calendars.inspect

	    ns = namespace.nylas_inbox

	    events_synced = 0
	    active_calendar_ids = params_[:active_ids]
	    inactive_calendar_ids = params_[:inactive_ids]
	    nylas_calendar_ids = {}

	    if active_calendar_ids.present?
	      user_calendars.select(:id, :calendar_id).where(id: active_calendar_ids).each { |cal| nylas_calendar_ids[cal.id] = cal.try(:calendar_id) }
	    end

	    deleted_events = 0
	    if inactive_calendar_ids.present?
	      event_condition = Event.where(calendar_id: inactive_calendar_ids)
	      deleted_events += event_condition.count
	      event_condition.destroy_all
	    end

	    if active_calendar_ids.present?
	      events = sync_period > 0 ? ns.events.where(starts_after: (Time.now - sync_period.months).to_i) : ns.events
	      events.each do |ne|
	        if nylas_calendar_ids.has_value?(ne.calendar_id)
	          event = Event.find_or_initialize_by(nylas_event_id: ne.id)
	          event.assign_nylas_object! ne, firm do
	            event.assign_attributes created_by: event.id ? event.created_by : 0, last_updated_by: event.id ? event.last_updated_by : 0, owner_id: namespace.user_id, firm_id: firm.id, calendar_id: nylas_calendar_ids.key(ne.calendar_id), namespace_id: namespace.id
	          end
	         # puts " EVENT -----------------------------> " + event.inspect
	          events_synced += 1
	        end
	      end
	      namespace.update(cursor: ns.latest_cursor, last_sync: Time.now, sync_period: sync_period)
	    end
	end
end