module TasksHelper
  def user_google_calendars
    @user.google_calendars.pluck(:google_id)
  end
end
