module DatesHelper

  def simple_format_date(date)
    date.try(:strftime, '%b %e, %Y')
  end

  def simple_format_datetime(date)
    date.try(:strftime, '%b %e, %Y %l:%M %p')
  end

  def input_format_date(date)
    date.try(:strftime, '%d.%m.%Y')
  end

  def date_to_input(date)
    date.try(:strftime, '%m/%d/%Y')
  end

  def simple_input_format_date(date)
    date.try(:strftime, '%F')
  end

end