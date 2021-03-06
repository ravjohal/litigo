class Calendar < ActiveRecord::Base
  belongs_to :namespace
  has_many :events, :dependent => :destroy
  belongs_to :firm

  def delete!
    self.deleted = true
    Event.delete_all(:calendar_id => id)
    save!
  end

  def user
    self.namespace.user # It use instance, non relation - so use "includes" produce error
  end
end