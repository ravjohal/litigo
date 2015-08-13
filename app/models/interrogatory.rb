class Interrogatory < ActiveRecord::Base
	before_create :save_firm_case_user_for_child

	belongs_to :firm
	belongs_to :case
	belongs_to :user, class_name: 'User', foreign_key: 'created_by_id'

	has_many :children, class_name: "Interrogatory", foreign_key: "parent_id", :dependent => :destroy
	belongs_to :parent, class_name: "Interrogatory"

	accepts_nested_attributes_for :children, :reject_if => :all_blank, :allow_destroy => :true


  def save_firm_case_user_for_child
  	if self.parent_id
  	  self.case = self.parent.case
  	  self.firm = self.parent.firm
      self.user = self.parent.user
  	end
  end
end
