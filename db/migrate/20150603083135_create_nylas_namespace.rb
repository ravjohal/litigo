class CreateNylasNamespace < ActiveRecord::Migration
  def change
    create_table :namespaces do |t|
      t.string :namespace_id
      t.string :account_id
      t.string :email_address
      t.string :name
      t.string :provider
      t.integer :user_id
      t.string :inbox_token
      t.string :account_status
    end
  end
end
