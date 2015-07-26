class ConversionToPopulateFirmIdToModelsMissingIt < ActiveRecord::Migration
  def up
  	Event.all.each do |event|
  		firm = event.firm
	  	event.event_participants.each do |ep|
	  		ep.firm = firm
	  		ep.save!
	  		ep.participant.firm = firm
	  		ep.participant.save!
	  	end
	end

  	Calendar.all.each do |calendar|
  		firm = calendar.user.firm
  		calendar.firm = firm
  		calendar.save!
  	end

  	Namespace.all.each do |namespace|
  		firm = namespace.user.firm
  		namespace.firm = firm
  		namespace.save!
  	end
  end

  def down
  	Participant.all.each do |participant|
  		participant.firm = nil
  	end

  	EventParticipant.all.each do |ep|
  		ep.firm = nil
  	end

  	Calendar.all.each do |calendar|
  		calendar.firm = nil
  	end

  	Namespace.all.each do |namespace|
  		namespace.firm = nil
  	end
  end
end

