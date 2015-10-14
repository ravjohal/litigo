class AddExtensionToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :extension, :string
  end
end
