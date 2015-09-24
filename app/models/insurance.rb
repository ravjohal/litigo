class Insurance < ActiveRecord::Base
	before_create :save_firm_case_user_for_child

	before_save :save_case_contacts_adjuster, :if => :need_to_save_adjuster?

  INSURANCE_PROVIDERS = ['Allstate', 'State Farm', 'GIECO', 'Progressive', 'AAA', 'American Family', 'Mercury', 'Nationwide', 'Farmers', 'Travelers', 'Esurance', 'Self-insured', 'Other']

  belongs_to :case
  belongs_to :firm
  belongs_to :user
  belongs_to :company
  belongs_to :adjustor, class_name: 'Contact'
  belongs_to :policy_holder_contact, class_name: 'Contact', :foreign_key => :policy_holder_id
  has_many :children, class_name: "Insurance", foreign_key: "parent_id", :dependent => :destroy
  belongs_to :parent, class_name: "Insurance"

  accepts_nested_attributes_for :children, :reject_if => :all_blank, :allow_destroy => :true

  amoeba do
    enable
  end

  def self.total_policy_limit_amount(case_)
  	Insurance.where(:case_id => case_.id).sum(:policy_limit)
  end

  def self.total_amount_paid(case_)
    Insurance.where(:case_id => case_.id).sum(:amount_paid)
  end

  def save_firm_case_user_for_child
  	if self.parent_id
  		self.case = self.parent.case
  		self.firm = self.parent.firm
      self.user = self.parent.user
  	end
  end

  private

  def need_to_save_adjuster?
    self.case && adjustor_id_changed?
  end

  def save_case_contacts_adjuster
    self.case.case_contacts.create({:role => 'Adjuster', contact_id: adjustor_id, source: :insurance}) if adjustor_id && !self.case.case_contacts.where(:role => 'Adjuster', contact_id: adjustor_id).exists?
    self.case.case_contacts.where(contact_id: adjustor_id_was, :role => 'Adjuster', :source => 1).delete_all if adjustor_id_was && self.case.case_contacts.where(contact_id: adjustor_id_was, :role => 'Adjuster', :source => 1).exists?
  end

end
