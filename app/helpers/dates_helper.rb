module DatesHelper

  MONTH = {
      1 => 'Jan',
      2 => 'Feb',
      3 => 'Mar',
      4 => 'Apr',
      5 => 'May',
      6 => 'June',
      7 => 'July',
      8 => 'Aug',
      9 => 'Sep',
      10 => 'Oct',
      11 => 'Nov',
      12 => 'Dec'
  }

  def reg_exp_date(date)
    date_re = /^\d{4}\-\d{2}\-\d{2}/
    date_re.match(date.to_s.split(' ').first).to_s.split('-')
  end

  def simple_format_datetime_regexp(date)
    match = reg_exp_date(date)
    [MONTH[match[1].to_i], match[2], match[0], date.to_s.split(' ')[1]].join(' ')
  end

  def simple_format_date_regexp(date)
    match = reg_exp_date(date)
    [MONTH[match[1].to_i], match[2], match[0]].join(' ')
  end

  def date_to_input_regexp(date)
    match = reg_exp_date(date)
    [match[1], match[2], match[0]].join('/')
  end

  def time_to_input_regexp(date)
    date.to_s.split(' ')[1]
  end
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

  def date_to_input_with_zero(date)
    date.try(:strftime, '%-m/%d/%Y')
  end

  def time_to_input(date)
    date.try(:strftime, '%I:%M %p')
  end

  def simple_input_format_date(date)
    date.try(:strftime, '%F')
  end

  def convert_date_by_user_timezone(date, user)
    Time.zone = user.time_zone if user
    time_strptime = Time.strptime(date, '%m/%d/%Y')
    time_strptime - Time.zone.utc_offset + time_strptime.utc_offset
  end

end
