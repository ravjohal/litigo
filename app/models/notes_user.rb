class NotesUser < ActiveRecord::Base

  belongs_to :secondary_owner, class_name: 'User', foreign_key: 'secondary_owner_id'
  belongs_to :secondary_note,  class_name: 'Note', foreign_key: 'secondary_note_id'
  has_many :notifications, as: :notificable
end
