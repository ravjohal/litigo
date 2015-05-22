class RenameExpertWitnessToExpert < ActiveRecord::Migration
  def up
    Contact.where(type: 'ExpertWitness').each do |contact|
      contact.type = 'Expert'
      contact.save
    end
  end

  def down
    Contact.where(type: 'Expert').each do |contact|
      contact.type = 'ExpertWitness'
      contact.save
    end
  end
end
