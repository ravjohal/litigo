class AddInsuranceProviderToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :insurance_provider, :string
  end
end
