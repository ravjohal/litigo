class Insurance < ActiveRecord::Base
  INSURANCE_PROVIDERS = ['Allstate', 'State Farm', 'GIECO', 'Progressive', 'AAA', 'American Family', 'Mercury', 'Nationwide', 'Farmers', 'Travelers', 'Esurance', 'Self-insured', 'Other']

  belongs_to :case
  belongs_to :firm
  has_many :children, class_name: "Insurance", foreign_key: "parent_id", :dependent => :destroy
  belongs_to :parent, class_name: "Insurance"

  accepts_nested_attributes_for :children, :reject_if => :all_blank, :allow_destroy => :true
end
