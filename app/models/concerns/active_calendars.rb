module ActiveCalendars

  def enabled_calendars
    calendars.where(:deleted => false)
  end

  def active_calendars
    enabled_calendars.where(:active => true)
  end

end