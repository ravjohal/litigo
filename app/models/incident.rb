class Incident < ActiveRecord::Base
  
  INSURANCE_PROVIDERS = ['Allstate', 'State Farm', 'GIECO', 'Progressive', 'AAA', 'American Family', 'Mercury', 'Nationwide', 'Farmers', 'Travelers', 'Esurance', 'Self-insured', 'Other']

  belongs_to :case
  belongs_to :firm
  belongs_to :user
  after_save :check_sol

  def check_sol
    if self.case.present? && incident_date_changed? && incident_date.present?
      options = {incident_date_changed: incident_date_changed?}
      self.case.calculate_sol(self)
    end
  end
end
