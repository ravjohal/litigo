class EventSeries < ActiveRecord::Base
  # Recurring events is an Event Series

  belongs_to :user
  belongs_to :firm
  has_many :events, :dependent => :destroy

  attr_accessor :title, :description, :location, :update_all_events

  END_TIME = Date.parse('1 Jan, 2020').to_time

  after_create :create_events_until_end_time
  
  def create_events_until_end_time
    st = starts_at
    et = ends_at
    p = r_period(period)
    nst, net = st, et
    end_time = recur_end_date.present? ? recur_end_date : END_TIME

    while frequency.send(p).from_now(st) <= ActiveSupport::TimeZone[user.time_zone].parse("#{ends_at.hour}:#{ends_at.min}:#{ends_at.sec}, #{end_time.day}-#{end_time.month}-#{end_time.year}")+1.send(p)
      event = events.create(:title => title, :description => description, :location => location, :all_day => all_day, :starts_at => nst,
                                 :ends_at => net, :firm_id => firm_id, :user_id => user_id)
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

  def update_events_until_end_time(event_params, firm_id, attrs, calendar = nil)
    calendar ||= Calendar.find(event_params[:calendar_id]) if event_params[:calendar_id].present?
    events.each do |event|
      event_attrs = attrs.merge({
        starts_at: event_params[:all_day] ? event.starts_at : EventDateConverter.convert_query_time(EventDateConverter.convert_time_to_query_date(event.starts_at), event_params[:start_time]),
        ends_at: event_params[:all_day] ? event.ends_at : EventDateConverter.convert_query_time(EventDateConverter.convert_time_to_query_date(event.ends_at), event_params[:end_time])
      })
      event.main_update_handler event_attrs, event_params, calendar, firm_id
    end

  end
  
  def r_period(period)
    case period
      when 'Daily'
        p = 'days'
      when 'Weekly'
        p = 'weeks'
      when 'Monthly'
        p = 'months'
      when 'Yearly'
        p = 'years'
      else
        p = nil
    end
    p
  end

  def assign_participants(str, firm_id)
    if str.present?
      participants = str.split(',')
      participants.each do |p_email|
        participant = Participant.find_or_create_by(email: p_email, firm_id: firm_id)
        self.events.each { |e| EventParticipant.create(event_id: e.id, participant_id: participant.id, firm_id: firm_id) }
      end
    end
  end

  def create_process(calendar, nylas, firm_id = nil)
    events.each { |e| e.create_process calendar, nylas, firm_id }
  end

end
