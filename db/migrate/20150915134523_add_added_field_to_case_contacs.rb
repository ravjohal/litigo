class AddAddedFieldToCaseContacs < ActiveRecord::Migration

  def up
    add_column :case_contacts, :source, :integer
  end

  def down
    remove_column :case_contacts, :source
  end

end
