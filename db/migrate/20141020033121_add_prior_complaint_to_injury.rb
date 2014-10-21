class AddPriorComplaintToInjury < ActiveRecord::Migration
  def change
    add_column :injuries, :prior_complaint, :boolean
  end
end
