module TasksHelper
  def user_google_calendars
    @user.google_calendars.collect { |c| [ "<!--email_off--> #{c.google_id} <!--/email_off-->".html_safe, c.google_id] }
  end
end
