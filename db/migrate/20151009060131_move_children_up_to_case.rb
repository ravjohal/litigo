class MoveChildrenUpToCase < ActiveRecord::Migration
  def change
  	Case.all.each do |case_|
  		puts "CASE --------------------- " + case_.inspect
  		puts "INSURANCES >>>>>>>>>>>>>>>>> " + case_.insurance.inspect
  		case_.insurances << case_.insurance.try(:children) if case_.insurance
  		case_.interrogatories << case_.interrogatory.try(:children) if case_.interrogatory

  		case_.insurance.delete if case_.insurance
  		case_.interrogatory.delete if case_.interrogatory
  	end
  end
end
