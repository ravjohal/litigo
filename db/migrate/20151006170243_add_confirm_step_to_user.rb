class AddConfirmStepToUser < ActiveRecord::Migration

  def up
    add_column :users, :confirm_step, :integer, :default => 1
    User.where('firm_id > 0').update_all(confirm_step: 4)
  end

  def down
    remove_column :users, :confirm_step
  end

end
