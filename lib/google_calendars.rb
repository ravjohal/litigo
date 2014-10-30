class GoogleCalendars
  class << self
    def get_calendars_list(user)
      client = init_client(user)
      calendar = client.discovered_api('calendar', 'v3')
      page_token = nil
      #getting google calendars
      result = client.execute(:api_method => calendar.calendar_list.list)
      while true
        entries = result.data.items
        entries.each do |e|
          google_calendar = GoogleCalendar.find_or_initialize_by(google_id: e['id'])
          next if google_calendar.etag.present? && google_calendar.etag == e['etag']
          google_calendar.user_id = user.id
          google_calendar.firm_id = user.firm_id
          google_calendar.google_id = e['id']
          google_calendar.etag = e['etag']
          google_calendar.summary = e['summary']
          google_calendar.description = e['description']
          google_calendar.timeZone = e['timeZone']
          google_calendar.selected = e['selected']
          google_calendar.primary = e['primary']
          google_calendar.save

        end
        if !(page_token = result.data.next_page_token)
          break
        end
      end
      # @calendars = []
      # GoogleCalendar.all.each do |cal|
      #   @calendars.push({id: cal.google_id, summary: cal.summary})
      # end
    end
    
    def get_events(user, calendar_id)
      client = init_client(user)
      calendar = client.discovered_api('calendar', 'v3')
      google_calendar = client.execute(
          :api_method => calendar.events.list,
          :parameters => {'calendarId' => calendar_id},
          :headers => {'Content-Type' => 'application/json'})
      while true
        events = google_calendar.data.items
        events.each do |e|
          google_event = Event.find_or_initialize_by(google_id: e['id'])
          next if google_event.etag.present? && google_event.etag == e['etag']
          google_event.update(
              {
                  etag: e['etag'],
                  google_calendar_id: calendar_id,
                  google_id: e['id'],
                  status: e['status'],
                  htmlLink: e['htmlLink'],
                  summary: e['summary'],
                  all_day: !e['start']['dateTime'].present?,
                  start: e['start']['dateTime'].present? ? e['start']['dateTime'] : e['start']['date'],
                  end: e['end']['dateTime'].present? ? e['end']['dateTime'] : e['end']['date'],
                  endTimeUnspecified: e['endTimeUnspecified'],
                  transparency: e['transparency'],
                  visibility: e['visibility'],
                  location: e['location'],
                  iCalUID: e['iCalUID'],
                  sequence: e['sequence'],
                  owner_id: user.id,
                  firm_id: user.firm.id
              }
          )
          creator = Contact.find_or_initialize_by(email: e['creator']['email'])
          creator.update({email: e['creator']['email'], type: 'General'})
          event_attandee = EventAttendee.create({
                                                    event_id: google_event.id,
                                                    display_name: e['creator']['displayName'],
                                                    contact_id: creator.id,
                                                    creator: true
                                                })


          e['attendees'].each do |attrs|
            if attrs['email'] != creator.email
              contact = Contact.find_or_initialize_by(email: e['creator']['email'])
              contact.update_attributes(
                  {
                      email: e['creator']['email'],
                      type: 'General',
                  }
              )

              attendee = EventAttendee.create({
                                                  event_id: google_event.id,
                                                  display_name: e['creator']['displayName'],
                                                  contact_id: contact.id,
                                                  response_status: attrs['responseStatus']
                                              })
            end
          end
        end
        if !(page_token = google_calendar.data.next_page_token)
          break
        end
      end
    end
    
  private

    def init_client(user)
      client = Google::APIClient.new
      client.authorization.access_token = user.oauth_token
      client.authorization.client_id = ENV["GOOGLE_CLIENT_ID"]
      client.authorization.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
      client.authorization.refresh_token = user.oauth_refresh_token
      return client
    end
  end
end