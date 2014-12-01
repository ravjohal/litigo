class AddEncryptedSsnToContact < ActiveRecord::Migration
  def change
    change_table(:contacts) do |t|
      t.column :encrypted_ssn, :string
    end
  end
end
