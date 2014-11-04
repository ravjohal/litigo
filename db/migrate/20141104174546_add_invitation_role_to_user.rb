class AddInvitationRoleToUser < ActiveRecord::Migration
  def change
    add_column :users, :invitation_role, :integer
  end
end