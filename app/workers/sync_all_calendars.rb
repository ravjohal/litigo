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


class SyncAllCalendars
  extend LoggedJob
  extend RetriedJob
  # extend ScaledJob

	@queue = :calendar

	def self.perform
    Rails.logger.fatal "SyncAllCalendars - start - #{Time.now}"

   # Firm.find_each{|firm| firm.sync_namespace(firm) }

  sync_period = 3

  events_synced = 0

  enabled_namespaces.includes(:calendars).each do |namespace| #grab only those namespaces that are still enabled in nylas and loop on each
    ns = namespace.nylas_inbox
    nylas_calendar_ids = {}
    firm = namespace.firm

    events = sync_period > 0 ? ns.events.where(starts_after: (Time.now - sync_period.months).to_i) : ns.events

    events.each do |nylas_event|
      if nylas_calendar_ids.has_value?(nylas_event.calendar_id)
        event = Event.find_or_initialize_by(nylas_event_id: nylas_event.id)
        event.assign_nylas_object! nylas_event, firm do
          event.assign_attributes created_by: event.id ? event.created_by : 0, last_updated_by: event.id ? event.last_updated_by : 0, owner_id: namespace.user_id, firm_id: firm.id, calendar_id: nylas_calendar_ids.key(nylas_event.calendar_id), namespace_id: namespace.id
        end
       # puts " EVENT -----------------------------> " + event.inspect
        events_synced += 1
      end
    end
    namespace.update(last_sync: Time.now, sync_period: sync_period)
  end



    Rails.logger.fatal "SyncAllCalendars - end - #{Time.now}"
  end

end