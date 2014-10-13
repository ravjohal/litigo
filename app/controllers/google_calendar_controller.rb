class GoogleCalendarController < ApplicationController
  before_action :verify_authorized, except: [:get_all_calendars]
  def get_all_calendars
    client = init_client

    service = client.discovered_api('calendar', 'v3')
    @result = client.execute(
        :api_method => service.calendar_list.list,
        :parameters => {},
        :headers => {'Content-Type' => 'application/json'})
  end

  def get_all_events
    client = init_client

    service = client.discovered_api('calendar', 'v3')
    @result = @client.execute(
        :api_method => calendar.events.list,
        :parameters => {'calendarId' => 'primary'},
        :headers => {'Content-Type' => 'application/json'})
  end

  private

  def init_client
    client = Google::APIClient.new
    # Fill client with all needed data
    client.authorization.access_token = @token #token is taken from auth table
    client.authorization.client_id = @oauth2_key
    client.authorization.client_secret = @oauth2_secret
    client.authorization.refresh_token = @refresh_token
    return client
  end
end
