class Task < ActiveRecord::Base
	# has_many :case_tasks, :dependent => :destroy
	# has_many :cases, :through => :case_tasks
  belongs_to :case
  has_many :children, class_name: "Task", foreign_key: "parent_id", :dependent => :destroy
  has_one :event
  belongs_to :parent, class_name: "Task"
  belongs_to :user #this is the person who created the task
	belongs_to :firm
	belongs_to :owner, class_name: 'User' #this is the person who is the primary owner of this task
	belongs_to :secondary_owner, class_name: 'User' #the secondary owner of this task
  belongs_to :task_draft
  #before_update :toggle_event
  before_save :reset_event_date

  attr_accessor :add_event, :calendar_id

  def set_due_date!(date)
    if date.present?
      operator = self.conjunction.downcase == 'after' ? '+' : '-'
      self.update(due_date: date.method(operator).(self.due_term.days))
      if self.children.present?
        self.children.each do |child|
          child.set_due_date!(self.due_date)
        end
      end
    end
  end

  def create_event
    if self.calendar_id.present?
      calendar = Calendar.find(self.calendar_id)
    end

    event = Event.create(title: "#{self.try(:name)} - #{self.try(:case).try(:name)}",
                 description: self.description,
                 task_id: self.id,
                 starts_at: self.due_date,
                 ends_at: self.due_date,
                 created_by: self.user_id,
                 last_updated_by: self.user_id,
                 owner_id: calendar ? calendar.user.id : self.user_id,
                 firm_id: self.firm_id
    )
    if calendar
      event.calendar = calendar
      namespace = calendar.namespace
      nylas_namespace = namespace.nylas_namespace
      n_event = nylas_namespace.events.build(:calendar_id => calendar.calendar_id, :title => event.title, :description => event.description,
                                             :location => event.location, :when => {:start_time => event.starts_at.to_i,
                                                                                     :end_time => event.ends_at.to_i},
                                             :participants => event.participants.map {|p| { :email => p.email, :name => p.name}})
      n_event.save!
      event.update(calendar_id: calendar.id, nylas_event_id: n_event.id, nylas_calendar_id: n_event.calendar_id,
                    nylas_namespace_id: n_event.namespace_id, namespace_id: calendar.namespace_id,
                    when_type: n_event.when['object'])
    end
  end

  def delete_event
    if self.google_calendar_id.present?
      GoogleCalendars.delete_event(self.user, self.event)
      self.event.destroy!
    end
  end

  def toggle_event
    if self.event.present? && !self.add_event
      self.delete_event
    elsif self.event.blank? && self.add_event
      self.create_event
    end
  end

  def reset_event_date
    if self.event.present? && due_date_changed?
      self.event.update(start: self.due_date, end: self.due_date)
      GoogleCalendars.update_event(self.user, self.event)
    end
  end

  def row_color
    if self.due_date.present? && self.completed.blank?
      if self.due_date - Date.today <= 2
        return 'danger'
      elsif self.due_date - Date.today<= 7 && self.due_date - Date.today > 2
        return 'warning'
      end
    elsif self.completed.present?
      return 'success'
    end
  end

  def self.active_tasks_scope
    where("due_date IS NOT NULL AND completed IS NULL")
  end

  def self.completed_tasks_scope
    where.not(completed: nil)
  end

  def self.no_due_date_tasks_scope
    where(due_date: nil)
  end
end
