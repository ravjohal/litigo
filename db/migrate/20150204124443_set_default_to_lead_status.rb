class SetDefaultToLeadStatus < ActiveRecord::Migration
  def up
    change_column :leads, :status, :string, :default => 'pending_review'
    remove_column :leads, :call_date
  end

  def down
    change_column :leads, :status, :string, :default => nil
    add_column :leads, :call_date, :date
  end
end
