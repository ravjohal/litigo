class RemoveCaseTypeIdAndSubtypeIdFromCase < ActiveRecord::Migration
  def change
    remove_column :cases, :case_type_id
    remove_column :cases, :subtype_id
  end
end
