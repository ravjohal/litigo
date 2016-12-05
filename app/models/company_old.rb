class CompanyOld < ActiveRecord::Base
  has_many :medical_bills
  has_many :contacts
  has_many :insurances
  belongs_to :firm
  belongs_to :user

  accepts_nested_attributes_for :contacts, :reject_if => :all_blank

  def company_city_and_state
    if self.city.present? && self.state.present?
      "#{self.city}, #{self.state}"
    end
  end

  def company_city_or_state
    if self.city.blank? && self.state.present?
      self.state
    elsif self.state.blank? && self.city.present?
      self.city
    else
      self.company_city_and_state
    end
  end
end
