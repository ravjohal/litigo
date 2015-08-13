module EventDateConverter

  def self.parse_query_date(date)
    Date.strptime(date, '%m/%d/%Y')
  end

  def self.format_query_date(date)
    date.strftime('%Y-%m-%d')
  end

  def self.convert_query_date(date)
    self.format_query_date(self.parse_query_date(date))
  end

  def self.convert_query_time(date, time)
    self.format_query_time(self.parse_query_date_time(date, time))
  end

  def self.parse_query_time(time)
    DateTime.strptime(time, '%m/%d/%Y %H:%M %p')
  end

  def self.parse_query_date_time(date, time)
    self.parse_query_time "#{date} #{time}"
  end

  def self.format_query_time(time)
    time.strftime('%Y-%m-%d %H:%M %p')
  end

  def self.convert_time_to_query_date(time)
    time.strftime('%m/%d/%Y')
  end

end