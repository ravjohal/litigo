module SyncNamespaces

  def sync_namespace(firm, errors=[], errors_count=0, events_synced=0, updated_events_hash={}, updating_events=0, new_events=0, updated_events=0)
    enabled_namespaces.includes(:calendars).each do |namespace|
      begin
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

                  event.new_record? ?
                      new_events += 1 :
                      if updated_events_hash[event.id]
                        updating_events += 1
                      else
                        updated_events += 1
                        updated_events_hash[event.id] = true
                      end

                  if ne.status == 'cancelled'
                    event.destroy
                  else
                    event.assign_nylas_while_refresh ne, firm, calendar, namespace
                  end
                end
              end
              events_synced += 1
              last_cursor = ne.cursor
            end
          end

          namespace.update(cursor: last_cursor) if last_cursor.present?
        end
      rescue Exception => e
        Rails.logger.fatal "Error while refresh events\n - Time: #{Time.now}\n  - Namespace: #{namespace.email_address}\n Message:#{e.message}\n - Backtrace: #{e.backtrace.join("\n")}"
        errors_count += 1
        errors << "Error with namespace #{namespace.email_address}\n#{e.message}"
      end
    end
  end

end