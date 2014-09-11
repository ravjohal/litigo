class RenameContactableTypeInContacts < ActiveRecord::Migration
  def change
  	rename_column :contacts, :contactable_type, :type
  end
end
