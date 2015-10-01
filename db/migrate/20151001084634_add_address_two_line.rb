class AddAddressTwoLine < ActiveRecord::Migration

  def up
    add_column :contacts, :address_2, :string
    add_column :firms, :address_2, :string
    add_column :leads, :address_2, :string
  end

  def down
    remove_column :contacts, :address_2
    remove_column :firms, :address_2
    remove_column :leads, :address_2
  end

end
