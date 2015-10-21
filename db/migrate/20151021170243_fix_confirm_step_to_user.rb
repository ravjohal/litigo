class FixConfirmStepToUser < ActiveRecord::Migration

  def up
    User.where('firm_id > 0 AND role = 1'). update_all(confirm_step: 5)
  end

end
