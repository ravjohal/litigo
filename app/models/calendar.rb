class Calendar < ActiveRecord::Base
  belongs_to :namespace
  has_many :events, :dependent => :destroy
  belongs_to :firm

  def user
  	self.namespace.includes[:user].user
  end
end