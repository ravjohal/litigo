class Calendar < ActiveRecord::Base
  belongs_to :namespace
  has_many :events
end