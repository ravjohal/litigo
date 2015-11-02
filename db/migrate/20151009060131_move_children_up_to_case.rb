class MoveChildrenUpToCase < ActiveRecord::Migration
  def change
  	Case.find_each do |case_|
  		puts "CASE --------------------- " + case_.inspect
  		puts "INSURANCES >>>>>>>>>>>>>>>>> " + case_.insurance.inspect if case_.try(:insurance)
  		case_.insurances << case_.insurance.try(:children) if case_.try(:insurance)
  		case_.interrogatories << case_.interrogatory.try(:children) if case_.try(:interrogatory)

  		case_.insurance.delete if case_.try(:insurance)
  		case_.interrogatory.delete if case_.try(:interrogatory)
  	end
  end
end
