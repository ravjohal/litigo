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
          creator.update({email: e['creator']['email']})
          event_attendee = EventAttendee.create({
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

    def create_event(user, event)
      p "!event.valid?: #{!event.valid?}"
      return if !event.valid?
      google_attendees = []
      google_event = {
          status: event.status,
          summary: event.summary,
          location: event.location,
          start: {},
          end: {},
          attendees: google_attendees
      }
      if event.all_day
        google_event[:start][:date] = event.start.to_date
        google_event[:end][:date] = event.end.to_date
      else
        google_event[:start][:dateTime] = event.start.to_datetime
        google_event[:end][:dateTime] = event.end.to_datetime
      end
      event.event_attendees.each do |attendee|
        google_attendees << {email: attendee.contact.email,
                             displayName: attendee.display_name.present? ? attendee.display_name : "#{attendee.contact.first_name} #{attendee.contact.last_name}"}
      end

      client = init_client(user)
      calendar = client.discovered_api('calendar', 'v3')
      p "google_event: #{google_event}"
      create_google_event = client.execute(
          :api_method => calendar.events.insert,
          :parameters => {'calendarId' => event.google_calendar_id, 'sendNotifications' => true},
          :body_object => google_event,
          :headers => {'Content-Type' => 'application/json'})
      response = JSON.parse(create_google_event.response.env[:body])
      p "response: #{response}"
      if create_google_event.response.status.to_i == 200
        event.update({
                          etag: response['etag'],
                          google_id: response['id'],
                          htmlLink: response['htmlLink'],
                          iCalUID: response['iCalUID'],
                          endTimeUnspecified: response['endTimeUnspecified'],
                          transparency: response['transparency'],
                          visibility: response['visibility'],
                          sequence: response['sequence']
                      })
        event.contacts.each do |contact|
          options = {
              user: user,
              send_to_contact: contact,
              contacts: event.contacts.pluck(:email),
              event: event
          }
          UserEmails.event_invitation(options).deliver
        end
      else
        errors = []
        response['error']['errors'].map {|error| errors << error['message']}
        event.errors.add(:google_calendar_id, errors.to_sentence)
        event.destroy!
      end
    end

    def update_event(user, event)
      return if !event.valid?
      google_attendees = []
      google_event = {
          status: event.status,
          summary: event.summary,
          location: event.location,
          start: {},
          end: {},
          attendees: google_attendees
      }
      if event.all_day
        google_event[:start][:date] = event.start.to_date
        google_event[:end][:date] = event.end.to_date
        google_event[:start][:dateTime] = nil
        google_event[:end][:dateTime] = nil
      else
        google_event[:start][:dateTime] = event.start.to_datetime
        google_event[:end][:dateTime] = event.end.to_datetime
        google_event[:start][:date] = nil
        google_event[:end][:date] = nil
      end
      event.event_attendees.each do |attendee|
        google_attendees << {email: attendee.contact.email,
                             displayName: attendee.display_name.present? ? attendee.display_name : "#{attendee.contact.first_name} #{attendee.contact.last_name}"}
      end

      client = init_client(user)
      calendar = client.discovered_api('calendar', 'v3')
      create_google_event = client.execute(
          :api_method => calendar.events.patch,
          :parameters => {'calendarId' => event.google_calendar_id, 'eventId' => event.google_id, 'sendNotifications' => true},
          :body_object => google_event,
          :headers => {'Content-Type' => 'application/json'})
      response = JSON.parse(create_google_event.response.env[:body])
      if create_google_event.response.status.to_i == 200
        event.update({
                         etag: response['etag'],
                         google_id: response['id'],
                         htmlLink: response['htmlLink'],
                         iCalUID: response['iCalUID'],
                         endTimeUnspecified: response['endTimeUnspecified'],
                         transparency: response['transparency'],
                         visibility: response['visibility'],
                         sequence: response['sequence']
                     })
      else
        errors = []
        response['error']['errors'].map {|error| errors << error['message']}
        event.errors.add(:google_calendar_id, errors.to_sentence)
        event.destroy!
      end

    end
    
  private

    def init_client(user)
      client = Google::APIClient.new
      fresh_token(user)
      client.authorization.access_token = user.oauth_token
      client.authorization.client_id = ENV["GOOGLE_CLIENT_ID"]
      client.authorization.client_secret = ENV["GOOGLE_CLIENT_SECRET"]
      client.authorization.refresh_token = user.oauth_refresh_token
      return client
    end

    def request_token_from_google(user)
      url = URI("https://accounts.google.com/o/oauth2/token")
      Net::HTTP.post_form(url, {'refresh_token' => user.oauth_refresh_token,
                                'client_id' => ENV['GOOGLE_CLIENT_ID'],
                                'client_secret' => ENV['GOOGLE_CLIENT_SECRET'],
                                'grant_type' => 'refresh_token'})
    end

    def refresh!(user)
      response = request_token_from_google(user)
      data = JSON.parse(response.body)
      user.oauth_token = data['access_token']
      user.oauth_expires_at = Time.now + (data['expires_in'].to_i).seconds
      user.save!
    end

    def expired?(user)
      user.oauth_expires_at < Time.now
    end

    def fresh_token(user)
      refresh!(user) if expired?(user)
    end
  end
end