class CaseTask < ActiveRecord::Base
	belongs_to :case 
	belongs_to :task
end
