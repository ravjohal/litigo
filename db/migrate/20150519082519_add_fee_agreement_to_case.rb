class AddFeeAgreementToCase < ActiveRecord::Migration
  def change
    add_column :cases, :fee_agreement, :boolean, :default => false
  end
end