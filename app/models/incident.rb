class Incident < ActiveRecord::Base
  
  INSURANCE_PROVIDERS = ['Allstate', 'State Farm', 'GIECO', 'Progressive', 'AAA', 'American Family', 'Mercury', 'Nationwide', 'Farmers', 'Travelers', 'Esurance', 'Self-insured', 'Other']

  belongs_to :case
  belongs_to :firm
  belongs_to :user
  before_save :check_sol
  before_save :set_tasks_due_dates

  def check_sol
    if self.case.present? && incident_date_changed? && incident_date.present?
      self.case.calculate_sol(self)
    end
  end

  # TODO: Refactor to avoid doing a lot of DB calls
  def set_tasks_due_dates
    attrs = TaskDraft::ANCHOR_DATE_HASH['incident'].keys & self.changed
    if attrs.present?
      attrs.each do |attr|
        self.case.tasks.where(anchor_date: "incident.#{attr}").each do |task|
          task.set_due_date!(self.try(attr))
        end
      end
    end
  end
end
