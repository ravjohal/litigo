class Namespace < ActiveRecord::Base
  belongs_to :user
  has_many :calendars, :dependent => :destroy

  def full_name
    name.present? ? "#{name}/#{provider}" : email_address
  end
end
