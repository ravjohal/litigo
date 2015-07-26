class Calendar < ActiveRecord::Base
  belongs_to :namespace
  has_many :events
  belongs_to :firm

  def user
  	self.namespace.user
  end
end