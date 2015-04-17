class CreateMedicalLines < ActiveRecord::Migration
  def change
    create_table :medical_lines do |t|
      t.string :provider
      t.date :date_of_service
      t.decimal :billed_amount
      t.decimal :paid_amount

      t.timestamps null: false
    end
  end
end
