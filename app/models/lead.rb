class Lead < ActiveRecord::Base
  belongs_to :screener, class_name: 'User', :foreign_key => 'screener_id'
  belongs_to :attorney, class_name: 'User', :foreign_key => 'attorney_id'
  belongs_to :firm
  belongs_to :case
end
