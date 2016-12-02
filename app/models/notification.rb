class Notification < ActiveRecord::Base
  belongs_to :notificable, polymorphic: true

  def self.mark_as_read(notifications)
    return unless notifications.any? { |note| !note.is_read? }

    Notification.transaction do
      notifications.each do |note|
        note.update_attribute(:is_read, true) unless note.is_read?
      end
    end
  end

end
