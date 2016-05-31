module SyncNamespaces

  def sync_namespace(firm, errors=[], errors_count=0, events_synced=0, updated_events_hash={}, updating_events=0, new_events=0, updated_events=0)
    enabled_namespaces.includes(:calendars).each do |namespace| #grab only those namespaces that are still enabled in nylas and loop on each
      begin
        active_calendars = namespace.active_calendars #grab only calendars that each namespace (per user) has active
        if active_calendars.present? #if there is at least one active calendar
          ns = namespace.nylas_inbox #create a new Nylas Inbox object

          puts " ns ns ns ns ns ns ns ns ns ns = " + ns.to_s

          cursor = namespace.nylas_cursor #figure out what the last cursor was (where the last sync left off)

          last_cursor_from_nylas = ns.latest_cursor

          puts "DO THE CURSORS MATCHUP??????  ===============> from DB: " + cursor.to_s + " from nylas: " + last_cursor_from_nylas.to_s

          puts "cursor cursor cursor cursor = " + cursor.to_s

          last_cursor = nil

          ns.deltas(cursor) do |n_event, ne| #grab all the deltas as of the cursor (new and modified)

            puts "n_event n_event n_event n_event n_event = " + n_event.to_s

            puts "ne ne ne ne ne ne ne ne ne ne ne ne ne = " + ne.inspect

            if ne.is_a?(Nylas::Event) #is this an Nylas Event type class that is coming from Nylas?
              if n_event == 'create' or n_event == 'modify' #is this a create or modify type of Nylas Event?
                calendar = active_calendars.find_by(calendar_id: ne.calendar_id) #get the calendar for what this event is for

                puts "calendar calendar calendar calendar calendar = " + calendar.inspect

                if calendar.present? #if that calendar is actually present
                  event = Event.find_or_initialize_by(nylas_event_id: ne.id) #find the event and update the NylasEvent ID or create new Litigo Event object

                  puts "event event event event event event event event = " + event.inspect

                  event.new_record? ?
                      new_events += 1 :
                      if updated_events_hash[event.id]
                        updating_events += 1
                      else
                        updated_events += 1
                        updated_events_hash[event.id] = true
                      end

                  puts "new_events new_events new_events new_events = " + new_events.to_s

                  if ne.status == 'cancelled'
                    event.destroy
                  else
                    event.assign_nylas_while_refresh ne, firm, calendar, namespace
                  end
                end
              end
              events_synced += 1
              last_cursor = ne.cursor

              puts "events_synced events_synced events_synced = " + events_synced.to_s

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