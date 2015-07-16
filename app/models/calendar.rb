class Calendar < ActiveRecord::Base
  belongs_to :namespace
  has_many :events

  def user
  	self.namespace.user
  end
end