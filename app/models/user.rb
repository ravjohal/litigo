class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         # confirmable is also another module we can add to devise to confirm user signup

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  after_initialize :set_show_onboarding, :if => :new_record?

  has_many :documents
  has_many :tasks
  has_and_belongs_to_many :events
  has_many :owned_events, class_name: "Event", foreign_key: "owner_id"
  has_many :contacts
  has_many :cases


  def set_default_role
    self.role ||= :user
  end

  def set_show_onboarding
    self.show_onboarding = true
  end

end
