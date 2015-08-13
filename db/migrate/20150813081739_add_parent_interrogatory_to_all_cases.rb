class AddParentInterrogatoryToAllCases < ActiveRecord::Migration
  def up
  	Case.all.each do |case_|
  		interrogatory = case_.build_interrogatory({:question => "", :firm_id => case_.firm_id, :case_id => case_.id, :created_by_id => case_.user_id, :last_updated_by_id => case_.user_id})
  		interrogatory.save!
  	end
  end

  def down
  	Interrogatory.delete_all
  end
end
