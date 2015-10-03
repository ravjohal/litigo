class NotificationsController < ApplicationController
  before_action :set_notification, only: [:show, :edit, :update, :destroy]

  before_filter :authenticate_user!
  before_action :set_user, :set_firm


  def index
    @from_time = Time.now
    @notifications = Notification.where(user_id: current_user.id).order(created_at: :desc)
    update_notification_flag
  end

  def remove_all
    @user = current_user
    @notifications = Notification.where(user_id: current_user.id)
    @notifications.destroy_all
    flash[:notice] = "You have removed all notifications!"
    redirect_to user_root_path(@user)
  end

  def destroy
    @user = current_user
    @notification.destroy
    respond_to do |format|
      format.html { redirect_to notifications_url, notice: 'Notification was successfully deleted' }
      format.json { head :no_content }
    end
  end

  private

  def update_notification_flag
    @notifications.each do |note|
      note.update_attribute(:is_read, true)
    end
  end

  def set_notification
    @notification = Notification.find(params[:id])
  end


  def load_notificable
    klass = [NotesUser].detect { |c| params["#{c.name.underscore}_id"]}
    @notificable = klass.find(params["#{klass.name.underscore}_id"])
  end


  # Use callbacks to share common setup or constraints between actions.
  # Never trust parameters from the scary internet, only allow the white list through.
  def notification_params
    params.require(:notification).permit(:user_id,:content, :note_id, :notificable_id, :notificable_type, :created_at, :updated_at, :is_read, :author )

  end
end
