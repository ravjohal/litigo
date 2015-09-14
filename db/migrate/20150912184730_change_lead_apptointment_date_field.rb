class ChangeLeadApptointmentDateField < ActiveRecord::Migration

  def up
    change_column :leads, :appointment_date, :datetime
  end

  def down
    change_column :leads, :appointment_date, :date
  end

end
