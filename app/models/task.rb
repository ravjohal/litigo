class Task < ActiveRecord::Base
	# has_many :case_tasks, :dependent => :destroy
	# has_many :cases, :through => :case_tasks
  belongs_to :case
  has_many :children, class_name: "Task", foreign_key: "parent_id", :dependent => :destroy
  has_one :event
  belongs_to :parent, class_name: "Task"
  belongs_to :user
	belongs_to :firm
	belongs_to :owner, class_name: 'User'
  belongs_to :task_draft
  before_update :toggle_event
  before_save :reset_event_date

  attr_accessor :add_event, :google_calendar_id

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
    event = Event.create(subject: "Task - #{self.try(:case).try(:name)}",
                 date: self.due_date,
                 all_day: true,
                 notes: self.description,
                 task_id: self.id,
                 start: self.due_date,
                 end: self.due_date,
                 owner_id: self.user_id,
                 firm_id: self.firm_id
    )
    if self.google_calendar_id.present?
      event.google_calendar_id = self.google_calendar_id
      GoogleCalendars.create_event(self.user, event)
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
