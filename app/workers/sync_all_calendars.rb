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
    Firm.all.each do |firm|
      firm.enabled_namespaces.includes(:calendars).each do |namespace|
        active_calendars = namespace.active_calendars
        if active_calendars.present?
          ns = namespace.nylas_inbox
          cursor = namespace.nylas_cursor
          last_cursor = nil

          ns.deltas(cursor, Namespace::NYLAS_EXCLUDE_DELTA) do |n_event, ne|
            if ne.is_a?(Nylas::Event)
              if n_event == 'create' or n_event == 'modify'
                calendar = active_calendars.find_by(calendar_id: ne.calendar_id)
                if calendar.present?
                  event = Event.find_or_initialize_by(nylas_event_id: ne.id)
                  if ne.status == 'cancelled'
                    event.destroy
                  else
                    event.assign_nylas_while_refresh ne, @firm, calendar, namespace
                  end
                end
              end
              last_cursor = ne.cursor
            end
          end
          namespace.update(cursor: last_cursor) if last_cursor.present?
        end
      end
    end
  end

end