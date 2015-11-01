class Expense < ActiveRecord::Base
  belongs_to :user
  belongs_to :case
  belongs_to :firm
  belongs_to :invoice
end
