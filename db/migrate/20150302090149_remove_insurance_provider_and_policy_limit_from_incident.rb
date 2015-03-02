class RemoveInsuranceProviderAndPolicyLimitFromIncident < ActiveRecord::Migration
  def change
  	remove_column :incidents, :insurance_provider
  	remove_column :incidents, :policy_limit
  end
end
