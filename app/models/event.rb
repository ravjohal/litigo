class Event < ActiveRecord::Base
  belongs_to :user, class_name: 'User', foreign_key: 'created_by'
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  belongs_to :firm
  belongs_to :task
  belongs_to :calendar
  belongs_to :namespace
  belongs_to :event_series
  has_many :event_participants, :dependent => :destroy
  has_many :participants, :through => :event_participants

  attr_accessor :start_date, :start_time, :end_date, :end_time, :recur, :period, :frequency, :recur_start_date, :recur_end_date, :update_all_events
  validates_presence_of :starts_at, :ends_at
  validate :end_after_start

  REPEATS = %w(Daily Weekly Monthly Yearly)

  def apply_nylas_event(ne)
    case ne.when['object']
      when 'date'
        parsed_date = Time.parse ne.when['date']
        self.starts_at = Time.zone.local(parsed_date.year, parsed_date.month, parsed_date.day).to_datetime
        self.ends_at = Time.zone.local(parsed_date.year, parsed_date.month, parsed_date.day).to_datetime
        self.all_day = true
      when 'datespan'
        parsed_date = Time.parse ne.when['start_date']
        self.starts_at = Time.zone.local(parsed_date.year, parsed_date.month, parsed_date.day).to_datetime
        parsed_date = Time.parse ne.when['end_date']
        self.ends_at = Time.zone.local(parsed_date.year, parsed_date.month, parsed_date.day).to_datetime
        self.all_day = true
      when 'time'
        self.starts_at = Time.at(ne.when['time']).utc.to_datetime
        self.ends_at = Time.at(ne.when['time']).utc.to_datetime
        self.all_day = false
      when 'timespan'
        self.starts_at = Time.at(ne.when['start_time']).utc.to_datetime
        self.ends_at = Time.at(ne.when['end_time']).utc.to_datetime
        self.all_day = false
    end
  end

  def assign_nylas_object(ne)
    assign_attributes(
        nylas_calendar_id: ne.calendar_id,
        nylas_namespace_id: ne.namespace_id,
        description: ne.description,
        location: ne.location,
        read_only: ne.read_only,
        title: ne.title,
        busy: ne.try(:busy),
        status: ne.try(:status),
        when_type: ne.when['object']
    )
    yield if block_given?
  end

  def assign_nylas_object!(ne, firm)
    assign_nylas_object ne
    yield if block_given?
    apply_nylas_event! ne

    ne.participants.each do |np|
      participant = Participant.find_or_create_by(email: np['email'], name: np['name'], firm_id: firm.id)
      ep = EventParticipant.find_or_initialize_by(event_id: id, participant_id: participant.id, firm_id: firm.id)
      ep.update(status: np['status'])
    end
  end

  def apply_nylas_event!(ne)
    apply_nylas_event ne
    save
  end

  def end_after_start
    if self.starts_at.present? && self.ends_at.present? && self.ends_at < self.starts_at
      errors.add(:starts_at, 'Date Later Than End Date')
    end
  end

  def assign_participants(str, firm_id)
    if str.present?
      participants = str.split(',')
      participants.each do |p_email|
        participant = Participant.find_or_create_by(email: p_email, firm_id: firm_id)
        EventParticipant.create(event_id: self.id, participant_id: participant.id, firm_id: firm_id)
      end
    end
  end

  def updated_by
    User.find(self.last_updated_by)
  end

  def update_participants(str, firm_id)
    unless str.nil?
      participants = str.split(',')
      existed_participants = self.participants.map { |a| a.email }
      # event_participants = self.event_participants.to_a

      deleted_participiants = existed_participants - participants
      new_participiants = participants - existed_participants
      # common_participiants = participants & existed_participants

      new_participiants.each do |p_email|
        participant = Participant.find_or_create_by(email: p_email, firm_id: firm_id)
        EventParticipant.create(event_id: id, participant_id: participant.id, firm_id: firm_id)
      end

      deleted_participiants.each do |p_email|
        participant = Participant.find_or_create_by(email: p_email, firm_id: firm_id)
        EventParticipant.delete_all(event_id: id, participant_id: participant.id, firm_id: firm_id)
      end

      # participants.each do |p_email|
      #   participant = Participant.find_or_create_by(email: p_email, firm_id: firm_id)
      #   event_participant = EventParticipant.find_or_create_by(event_id: self.id, participant_id: participant.id, firm_id: firm_id)
      #   event_participants.delete(event_participant)
      # end
      # event_participants.each {|ep| ep.destroy }
      self.event_participants.reload
      self.participants.reload
    end
  end

  def nylas_time_attributes
    all_day? ? {:object => 'date', :date => starts_at.strftime('%Y-%m-%d')} : {:start_time => starts_at.to_i, :end_time => ends_at.to_i}
  end

  def create_process(calendar, nylas_namespace, firm_id = nil)

    n_event = nylas_namespace.events.build(:calendar_id => calendar.calendar_id, :title => title, :description => description, :location => location, :when => nylas_time_attributes, :participants => participants.map { |p| {:email => p.email, :name => p.name} })
    n_event.save!

    update_attributes = {calendar_id: calendar.id, nylas_event_id: n_event.id, nylas_calendar_id: n_event.calendar_id, nylas_namespace_id: n_event.namespace_id, namespace_id: calendar.namespace_id, when_type: n_event.when['object']}
    update_attributes[:firm_id] = firm_id if firm_id
    update(update_attributes)
  end

  def update_process(event_params, calendar, firm_id)
    update_participants(event_params[:participants], firm_id) unless event_params[:participants].nil?
    unless calendar.blank?
      nylas_namespace = calendar.namespace.nylas_namespace
      puts "NYLAS EVENT ID ----------------------------------- " + event_params.inspect + " nylas_event_id >>>>>>>>>>>>>>>>>>>>>>>>> " + nylas_event_id.to_s
      n_event = nylas_namespace.events.find(nylas_event_id)

      if !n_event
        create_process calendar, nylas_namespace, firm_id
      else
        n_event.title = title
        n_event.description = description
        n_event.location = location
        n_event.when = nylas_time_attributes
        n_event.participants = participants.map { |p| {:email => p.email, :name => p.name} }
        n_event.save!
        update(when_type: n_event.when['object']) if n_event.when['object'] != when_type
      end
    end
  end

  def main_update_handler(attrs, event_params, calendar, firm_id)
    update_process(event_params, calendar, firm_id) if update(attrs)
  end

  def make_update(event_params, attrs, firm_id)
    calendar = Calendar.find(event_params[:calendar_id]) if event_params[:calendar_id].present?
    calendar ||= nil

    if event_series.present? && event_params[:update_all_events] == 'true'
      event_series.update_events_until_end_time(event_params, firm_id, attrs, calendar)
    else
      main_update_handler attrs, event_params, calendar, firm_id
    end
  end

  def drag_update(event_drag_params, user_id)
    event_drag_params[:last_updated_by] = user_id
    if update(event_drag_params)
      unless calendar.blank?
        nylas_namespace = calendar.namespace.nylas_namespace

        n_event = nylas_namespace.events.find(nylas_event_id)
        n_event.when = nylas_time_attributes
        n_event.save!

        update(when_type: n_event.when['object']) if n_event.when['object'] != when_type
      end
      true
    else
      false
    end
  end

  def nylas_destroy(nylas_namespace = nil)
    nylas_namespace ||= calendar.try(:namespace).try(:nylas_namespace)
    nylas_namespace.events.delete(nylas_event_id) if destroy && nylas_event_id.present? && nylas_namespace.present?
  end

  def destroy_series
    nylas_namespace ||= calendar.try(:namespace).try(:nylas_namespace)
    event_series.events.each { |e| e.nylas_destroy nylas_namespace }
  end

  def to_json_hash
    {
        id: id,
        title: title,
        start: starts_at,
        end: ends_at,
        allDay: all_day
    }
  end

  # @param [Inbox::Event] ne
  # @param [Firm] firm
  # @param [Calendar] calendar
  # @param [Namespace] namespace
  def assign_nylas_while_refresh(ne, firm, calendar, namespace)
    assign_nylas_object!(ne, firm) { assign_attributes owner_id: calendar.namespace.user_id, firm_id: firm.id, calendar_id: calendar.id, namespace_id: namespace.id } if id && !changed?
  end

end
