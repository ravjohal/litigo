class AddPhoneBookToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :phone_book, :string
  end
end
