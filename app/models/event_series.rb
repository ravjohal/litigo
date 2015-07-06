class EventSeries < ActiveRecord::Base
  belongs_to :user
  belongs_to :firm
  has_many :events, :dependent => :destroy

  attr_accessor :title, :description, :location, :update_all_events

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

  def update_events_until_end_time(event_params)
    calendar = Calendar.find(event_params[:calendar_id]) if event_params[:calendar_id].present?
    self.events.each do |event|
      event_attrs = {
          title: event_params[:title],
          description: event_params[:description],
          location: event_params[:location],
          starts_at: event_params[:all_day] ? event.starts_at : DateTime.strptime("#{event.starts_at.strftime("%m/%d/%Y")} #{event_params[:start_time]}", '%m/%d/%Y %H:%M %p').strftime('%Y-%m-%d %H:%M %p'),
          ends_at: event_params[:all_day] ? event.ends_at : DateTime.strptime("#{event.ends_at.strftime("%m/%d/%Y")} #{event_params[:end_time]}", '%m/%d/%Y %H:%M %p').strftime('%Y-%m-%d %H:%M %p'),
          all_day: event_params[:all_day]
      }

      if event.update(event_attrs)
        event.update_participants(event_params[:participants]) if event_params[:participants].present?
        if calendar.present?
          namespace = calendar.namespace
          @inbox = Nylas::API.new(Rails.application.secrets.inbox_app_id, Rails.application.secrets.inbox_app_secret, namespace.inbox_token)
          nylas_namespace = @inbox.namespaces.first
          n_event = nylas_namespace.events.find(event.nylas_event_id)
          n_event.title = event.title
          n_event.description = event.description
          n_event.location = event.location
          n_event.when = {:start_time => event.starts_at.to_i, :end_time => event.ends_at.to_i}
          n_event.participants = event.participants.map {|p| { :email => p.email, :name => p.name}}
          n_event.save!
          event.update(when_type: n_event.when['object']) if n_event.when['object'] != event.when_type
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

  def assign_participants(str)
    if str.present?
      participants = str.split(",")
      participants.each do |p_email|
        participant = Participant.find_or_create_by(email: p_email)
        self.events.each do |e|
          event_participant = EventParticipant.create(event_id: e.id, participant_id: participant.id)
        end
      end
    end
  end

end
