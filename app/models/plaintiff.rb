class Plaintiff < Contact
  has_many :case_contacts, :dependent => :destroy, foreign_key: 'contact_id'
  has_many :affairs, :through => :case_contacts

  default_scope {where(:type => 'Plaintiff')}
  # after_save :check_sol

  def set_type
    self.type = 'Plaintiff'
  end

  # def check_sol
  #   if self.affairs.present? && (date_of_death_changed? || major_date_changed?)
  #     options = {date_of_death_changed: date_of_death_changed?, major_date_changed: major_date_changed?}
  #     self.affairs.each do |affair|
  #       affair.calculate_sol(self, options)
  #     end
  #   end
  # end

end
