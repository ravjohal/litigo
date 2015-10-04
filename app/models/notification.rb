class Notification < ActiveRecord::Base
  belongs_to :notificable, polymorphic: true
end
