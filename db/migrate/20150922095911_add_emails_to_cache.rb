class AddEmailsToCache < ActiveRecord::Migration

  def up
    Participant.find_each { |user| user.load_into_soulmate }
    Contact.find_each     { |user| user.load_into_soulmate }
  end

  def down

  end
end
