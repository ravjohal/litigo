class MoveInsuranceProviderAndPolicyLimitToInsurances < ActiveRecord::Migration
  def change
    Incident.find_each do |incident|
       Insurance.create(
       :insurance_provider => incident.insurance_provider,
       :policy_limit => incident.policy_limit,
       :case_id => incident.case_id,
       :firm_id => incident.firm_id
       )
     end
  end
end
