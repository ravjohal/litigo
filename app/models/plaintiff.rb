class Plaintiff < Contact
  default_scope {where(:type => 'Plaintiff')}
  after_save :check_sol

  def check_sol
    if self.cases.present? && (date_of_death_changed? || major_date_changed?)
      options = {date_of_death_changed: date_of_death_changed?, major_date_changed: major_date_changed?}
      self.cases.each do |affair|
        affair.calculate_sol(self, options)
      end
    end
  end

end
