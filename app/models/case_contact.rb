class CaseContact < ActiveRecord::Base
	belongs_to :affair, class_name: 'Case', :foreign_key => 'case_id'
	belongs_to :contact
	belongs_to :plaintiff, :foreign_key => :contact_id
  belongs_to :firm
  after_save :check_sol
  #before_create :set_role

  def set_role
    self.role = self.contact.type.to_s
  end

  def name_of_contact
    self.contact.name
  end

  def check_sol
    if self.role == 'Plaintiff'
      if self.affair.present? && (self.contact.date_of_death.present? || self.contact.major_date.present?)
        options = {date_of_death_changed: self.contact.date_of_death.present?, major_date_changed: self.contact.major_date.present?}
        self.affair.calculate_sol(self.contact, options)
      end
    end
  end

end
