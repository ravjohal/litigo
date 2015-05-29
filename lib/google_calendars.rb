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
          google_calendar = GoogleCalendar.where(google_id: e['id'], user_id: user.id).first_or_initialize
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
      p "calendar_id: #{calendar_id}"
      cal = GoogleCalendar.find_by(google_id: calendar_id, user_id: user.id)
      cal.update(active: true) if cal
      client = init_client(user)
      calendar = client.discovered_api('calendar', 'v3')
      google_calendar = client.execute(
          :api_method => calendar.events.list,
          :parameters => {'calendarId' => calendar_id, 'maxResults' => 2500, 'timeMin' => (Time.now - 1.year).strftime('%Y-%m-%dT%H:%M:%S+00:00')},
          :headers => {'Content-Type' => 'application/json'})
      response = JSON.parse(google_calendar.response.env[:body])
      p "response: #{response}"
      while true
        events = google_calendar.data.items
        events.each do |e|
          p "Event_from_Google: #{e.inspect}!!!!"
          google_event = Event.where(google_id: e['id'], owner_id: user.id).first_or_initialize
          p "google_event: #{google_event.inspect}\n\n\n"
          next if google_event.etag.present? && google_event.etag == e['etag']

          if e.try(:[],'start').try(:[], 'dateTime').present? || e.try(:[], 'start').try(:[], 'date').present?
            start_ = e.try(:[],'start').try(:[], 'dateTime').present? ? e.try(:[],'start').try(:[], 'dateTime') : e.try(:[], 'start').try(:[], 'date')
          elsif e.try(:[], 'originalStartTime').try(:[], 'dateTime').present? || e.try(:[], 'originalStartTime').try(:[], 'date').present?
            start_ = e.try(:[], 'originalStartTime').try(:[], 'dateTime').present? ? e.try(:[], 'originalStartTime').try(:[], 'dateTime') : e.try(:[], 'originalStartTime').try(:[], 'date')
          else
            start_ = e['created']
          end

          if e.try(:[],'end').try(:[], 'dateTime').present? || e.try(:[], 'end').try(:[], 'date').present?
            end_ = e.try(:[],'end').try(:[], 'dateTime').present? ? e.try(:[],'end').try(:[], 'dateTime') : e.try(:[], 'end').try(:[], 'date')
          elsif e.try(:[], 'originalStartTime').try(:[], 'dateTime').present? || e.try(:[], 'originalStartTime').try(:[], 'date').present?
            end_ = e.try(:[], 'originalStartTime').try(:[], 'dateTime').present? ? e.try(:[], 'originalStartTime').try(:[], 'dateTime') : e.try(:[], 'originalStartTime').try(:[], 'date')
          else
            end_ = e['created']
          end

          google_event.update(
              {
                  etag: e['etag'],
                  google_calendar_id: calendar_id,
                  google_id: e['id'],
                  status: e['status'],
                  html_link: e['htmlLink'],
                  subject: e['summary'],
                  # summary: e['summary'],
                  # all_day: e['start']['dateTime'].blank?,
                  all_day: e.try(:[],'start').try(:[], 'dateTime').blank?,
                  # start: e['start']['dateTime'].present? ? e['start']['dateTime'] : e['start']['date'],
                  start: start_,
                  # end: e['end']['dateTime'].present? ? e['end']['dateTime'] : e['end']['date'],
                  end: end_,
                  end_time_unspecified: e['endTimeUnspecified'],
                  transparency: e['transparency'],
                  visibility: e['visibility'],
                  location: e['location'],
                  iCalUID: e['iCalUID'],
                  sequence: e['sequence'],
                  owner_id: user.id,
                  firm_id: user.firm.id,
                  notes: e['description']
              }
          )

          e['attendees'].each do |attrs|
              contact = Contact.find_or_create_by(email: attrs['email'])
              attendee = EventAttendee.create({
                                                  event_id: google_event.id,
                                                  display_name: attrs['displayName'],
                                                  contact_id: contact.id,
                                                  response_status: attrs['responseStatus']
                                              })
          end
        end
        if !(page_token = google_calendar.data.next_page_token)
          break
        end
        google_calendar = client.execute(
            :api_method => calendar.events.list,
            :parameters => {'calendarId' => calendar_id, 'pageToken' => page_token},
            :headers => {'Content-Type' => 'application/json'})
        response = JSON.parse(google_calendar.response.env[:body])
      end
    end

    def create_event(user, event)
      p "!event.valid?: #{!event.valid?}"
      return if !event.valid?
      google_attendees = []
      google_event = {
          # status: event.status,
          summary: event.subject,
          location: event.location,
          start: {},
          end: {},
          description: event.notes,
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
                             displayName: attendee.display_name.present? ? attendee.display_name : attendee.contact.email}
      end

      client = init_client(user)
      calendar = client.discovered_api('calendar', 'v3')
      p "event: #{event.inspect}\n"
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
                          html_link: response['htmlLink'],
                          iCalUID: response['iCalUID'],
                          end_time_unspecified: response['endTimeUnspecified'],
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
          # status: event.status,
          summary: event.subject,
          # subject: event.summary,
          location: event.location,
          start: {},
          end: {},
          description: event.notes,
          attendees: google_attendees
      }
      if event.all_day
        google_event[:start][:date] = event.start.to_date
        google_event[:end][:date] = event.end.to_date
        # google_event[:start][:dateTime] = nil
        # google_event[:end][:dateTime] = nil
      else
        google_event[:start][:dateTime] = event.start.to_datetime
        google_event[:end][:dateTime] = event.end.to_datetime
        # google_event[:start][:date] = nil
        # google_event[:end][:date] = nil
      end
      event.event_attendees.each do |attendee|
        google_attendees << {email: attendee.contact.email,
                             displayName: attendee.display_name.present? ? attendee.display_name : attendee.contact.email}
      end

      client = init_client(user)
      calendar = client.discovered_api('calendar', 'v3')
      if event.google_id.present? && event.etag.present?
        create_google_event = client.execute(
            :api_method => calendar.events.patch,
            :parameters => {'calendarId' => event.google_calendar_id, 'eventId' => event.google_id, 'sendNotifications' => true},
            :body_object => google_event,
            :headers => {'Content-Type' => 'application/json'})
      else
        p "!!!create_event!!!"
        create_google_event = client.execute(
            :api_method => calendar.events.insert,
            :parameters => {'calendarId' => event.google_calendar_id, 'sendNotifications' => true},
            :body_object => google_event,
            :headers => {'Content-Type' => 'application/json'})
      end
      p "create_google_event: #{create_google_event.inspect}"
      response = JSON.parse(create_google_event.response.env[:body])

      if create_google_event.response.status.to_i == 200
        event.update({
                         etag: response['etag'],
                         google_id: response['id'],
                         html_link: response['htmlLink'],
                         iCalUID: response['iCalUID'],
                         end_time_unspecified: response['endTimeUnspecified'],
                         transparency: response['transparency'],
                         visibility: response['visibility'],
                         sequence: response['sequence']
                     })
      else
        errors = []
        response['error']['errors'].map {|error| errors << error['message']}
        event.errors.add(:google_calendar_id, errors.to_sentence)
        # event.destroy!
      end

    end

    def delete_event(user, event)
      return if !event.valid?
      client = init_client(user)
      calendar = client.discovered_api('calendar', 'v3')
      result = client.execute(:api_method => calendar.events.delete,
                              :parameters => {'calendarId' => event.google_calendar_id, 'eventId' => event.google_id})
    end
    
  private

    def init_client(user)
      client = Google::APIClient.new(
          :application_name => 'Litigo',
          :application_version => '1.0.0'
      )
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
      user.oauth_expires_at.blank? || user.oauth_expires_at < Time.now
    end

    def fresh_token(user)
      refresh!(user) if expired?(user)
    end
  end
end