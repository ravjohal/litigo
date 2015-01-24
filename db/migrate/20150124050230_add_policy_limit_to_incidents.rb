class AddPolicyLimitToIncidents < ActiveRecord::Migration
  def change
    add_column :incidents, :policy_limit, :decimal
  end
end
