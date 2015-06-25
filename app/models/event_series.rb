class EventSeries < ActiveRecord::Base
  belongs_to :user
  belongs_to :firm
  has_many :events, :dependent => :destroy

  attr_accessor :title, :description, :location

  END_TIME = Date.parse("1 Jan, 2020").to_time

  after_create :create_events_until_end_time
  
  def create_events_until_end_time
    st = starts_at
    et = ends_at
    p = r_period(period)
    nst, net = st, et
    end_time = recur_end_date.present? ? recur_end_date : END_TIME

    while frequency.send(p).from_now(st) <= ActiveSupport::TimeZone[self.user.time_zone].parse("#{ends_at.hour}:#{ends_at.min}:#{ends_at.sec}, #{end_time.day}-#{end_time.month}-#{end_time.year}")+1.send(p)
      event = self.events.create(:title => title, :description => description, :location => location, :all_day => all_day, :starts_at => nst,
                                 :ends_at => net, :firm_id => firm_id, :user_id => user_id, :recur => true)

      nst = st = frequency.send(p).from_now(st)
      net = et = frequency.send(p).from_now(et)
      
      if period.downcase == 'monthly' or period.downcase == 'yearly'
        begin 
          nst = DateTime.parse("#{starts_at.hour}:#{starts_at.min}:#{starts_at.sec}, #{starts_at.day}-#{st.month}-#{st.year}")
          net = DateTime.parse("#{ends_at.hour}:#{ends_at.min}:#{ends_at.sec}, #{ends_at.day}-#{et.month}-#{et.year}")
        rescue
          nst = net = nil
        end
      end
    end
  end
  
  def r_period(period)
    case period
      when 'Daily'
      p = 'days'
      when "Weekly"
      p = 'weeks'
      when "Monthly"
      p = 'months'
      when "Yearly"
      p = 'years'
    end
    return p
  end
  
end
