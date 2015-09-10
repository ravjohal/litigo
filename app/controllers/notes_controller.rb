class NotesController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm

  helper DatesHelper

  # GET /notes
  # GET /notes.json
  def index
    @user = current_user

    if get_case
      @notes = @case.notes.order("created_at desc")
      # @my_notes = @notes.joins(:case => [{:contacts => :user}]).where(:contacts => {:user_account_id => @user.id})
      @my_notes = @case.notes.where(:user => current_user)
      @new_path = new_case_note_path(@case)
      @notes_a = [@case, Note.new] #for modal partial rendering
      # puts "MY NOTES -0-0-0-0-0-0-0-0- " + @my_notes.to_sql.inspect
    else
      @notes = @firm.notes.includes(:case).order("created_at desc")

      # @my_notes = @notes.joins(:case => [{:contacts => :user}]).where(:contacts => {:user_account_id => @user.id})
      @my_notes = @user.notes.includes(:case)
      @my_secondary_notes = @user.secondary_notes.includes(:case)
      # puts "MY NOTES -0-0-0-0-0-0-0-0- " + @my_notes.to_sql.inspect
      @new_path = new_note_path
      @notes_a = Note.new #for modal partial rendering
    end

  end

  # GET /notes/1
  # GET /notes/1.json
  def show
    @note = Note.find(params[:id])
    restrict_access("notes") if @note.firm_id != @firm.id    
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
    restrict_access("notes") if @note.firm_id != @firm.id     
  end

  # POST /notes
  # POST /notes.json
  def create

    if get_case
      @note = @case.notes.build(note_params)
      path_notes = case_notes_path
    else
      @note = Note.new(note_params)
      path_notes = notes_path
    end
    @note.user = @user
    @note.firm = @firm

    respond_to do |format|
      if @note.save
        if note_params[:add_task]
          task = Task.new(name: note_params[:task_name], due_date: note_params[:task_due_date], sms_reminder: note_params[:task_sms_reminder],
                             email_reminder: note_params[:task_email_reminder], description: note_params[:task_description],
                             user_id: @user.id, firm_id: @firm.id, owner_id: note_params[:task_owner_id], secondary_owner_id: note_params[:task_secondary_owner_id],
                             case_id: note_params[:case_id], calendar_id: note_params[:task_calendar_id])
          if task.save
            if task.due_date.present?
              task.create_event
            end
          end
        end
        format.html { redirect_to path_notes, notice: 'Note was successfully created.' }
        format.json { render :show, status: :created, location: @note }
      else
        format.html { render :new }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json
  def update
    @user = current_user
    @note.user = @user
    respond_to do |format|
      if @note.update(note_params)
        format.html { respond_with @note, notice: 'Note was successfully updated' }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @user = current_user
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: 'Note was successfully deleted' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:note, :case_id, :user_id, :firm_id, :note_type, :created_at, :updated_at, :author,
                                   :task_name, :task_due_date, :task_sms_reminder, :task_email_reminder, :add_task,
                                   :task_description, :task_owner_id, :task_secondary_owner_id,
                                   :task_add_event, :task_calendar_id, :secondary_note_id, :secondary_owner_id,
                                   :notes_users_attributes => [:id, :secondary_note_id, :secondary_owner_id, :_destroy])

    end
end
