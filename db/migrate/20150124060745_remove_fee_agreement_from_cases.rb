class RemoveFeeAgreementFromCases < ActiveRecord::Migration
  def change
    remove_column :cases, :fee_agreement, :boolean
  end
end
