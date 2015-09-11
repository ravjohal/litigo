class RenameExtFieldToExtension < ActiveRecord::Migration
  def change
    rename_column :contacts, :ext, :extension
  end
end
