class AddComplaintAtSceneToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :complaint_at_scene, :boolean
  end
end
