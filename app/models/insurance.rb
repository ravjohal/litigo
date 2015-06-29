class Insurance < ActiveRecord::Base
	before_save :save_firm_case_user_for_child

  INSURANCE_PROVIDERS = ['Allstate', 'State Farm', 'GIECO', 'Progressive', 'AAA', 'American Family', 'Mercury', 'Nationwide', 'Farmers', 'Travelers', 'Esurance', 'Self-insured', 'Other']

  belongs_to :case
  belongs_to :firm
  belongs_to :user
  belongs_to :company
  has_many :children, class_name: "Insurance", foreign_key: "parent_id", :dependent => :destroy
  belongs_to :parent, class_name: "Insurance"

  accepts_nested_attributes_for :children, :reject_if => :all_blank, :allow_destroy => :true

  amoeba do
    enable
  end

  def self.total_policy_limit_amount(case_)
  	Insurance.where(:case_id => case_.id).sum(:policy_limit)
  end

  def save_firm_case_user_for_child
  	if self.parent_id
  		self.case = self.parent.case
  		self.firm = self.parent.firm
      self.user = self.parent.user
  	end
  end
end
