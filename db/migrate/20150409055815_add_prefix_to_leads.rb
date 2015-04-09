class AddPrefixToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :prefix, :string
  end
end
