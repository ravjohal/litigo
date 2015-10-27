class TasksController < ApplicationController
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::UrlHelper

  before_filter :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm

  helper DatesHelper

  # GET /tasks
  # GET /tasks.json
  def index
    if get_case
      @tasks = @case.tasks.includes(:case, :owner).active_tasks_scope
      @my_tasks = @case.tasks.includes(:case, :owner).where("owner_id = ? OR secondary_owner_id = ?", @user.id, @user.id).active_tasks_scope
      @new_path = new_case_task_path(@case)
      @tasks_a = [@case, Task.new] #for modal partial rendering
    else
      # @my_tasks = @user.owned_tasks.active_tasks_scope
      @my_tasks = @firm.tasks.includes(:case, :owner).where("owner_id = ? OR secondary_owner_id = ? AND firm_id = ?", @user.id, @user.id, @firm.id).active_tasks_scope
      @tasks = @firm.tasks.includes(:case, :owner).active_tasks_scope
      @new_path = new_task_path
      @tasks_a = Task.new #for modal partial rendering
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    restrict_access("tasks") if @task.firm_id != @firm.id     
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    restrict_access("tasks") if @task.firm_id != @firm.id     
    if get_case
      @tasks_a = [@case, @task] #for modal partial rendering
    else
      @tasks_a = @task #for modal partial rendering
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    if get_case
      @task = @case.tasks.create(task_params)
      path_tasks = case_tasks_path
    else
      @task = Task.new(task_params)
      path_tasks = tasks_path
    end

    @task.user = @user
    @task.firm = @firm

    respond_to do |format|
      if @task.save
        track_activity @task
        if @task.add_event && @task.due_date.present?
          @task.create_event
        end
        format.html { redirect_to path_tasks, notice: 'Task successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update

    if get_case
      @task = @case.tasks.create(task_params)
      path_tasks = case_tasks_path
    else
      path_tasks = tasks_path
    end
    respond_to do |format|
      if @task.update(task_params)
        track_activity @task
        format.html { redirect_to path_tasks, notice: 'Task successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    track_activity @task
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def complete_task
    @task = @user.owned_tasks.find_by(id: params[:task][:task_id].to_i) || @user.owned_tasks_secondary.find_by(id: params[:task][:task_id].to_i)
    if @task.blank?
      render :json => "Task couldn't be completed.", status: 403
    elsif @task.completed.blank? && @task.update({completed: Date.today})
      render :json => { success: true, date: @task.completed, message: "Task completed." }
    else
      render :json => 'Task already completed.', status: 403
    end
  end

  def get_tasks
    tasks_scope = params[:tasks_scope]
    tasks_owner = params[:tasks_owner]
    @case = Case.find(params[:case_id]) if params[:case_id].present?
    if @case.present?
      if tasks_owner == 'tasks'
        tasks = @case.tasks.try(tasks_scope)
      elsif tasks_owner == 'my_tasks'
        tasks = @case.tasks.where("owner_id = ? OR secondary_owner_id = ? AND firm_id = ?", @user.id, @user.id, @firm.id).try(tasks_scope)
      end
    else
      if tasks_owner == 'tasks'
        tasks = @firm.tasks.try(tasks_scope)
      elsif tasks_owner == 'my_tasks'
        tasks = @user.owned_tasks.try(tasks_scope)
        tasks += @user.owned_tasks_secondary.try(tasks_scope)
      end
    end
    data = []
    tasks.each do |task|
      data.push(
          {
              'DT_RowId' => task.id,
              'DT_RowClass' => task.row_color,
              '0' => task.case.present? ? link_to(task.case.name, case_path(task)) : '',
              '1' => task.try(:owner).try(:name),
              '2' => content_tag(:div, task.name, class: 'larger-td'),
              '3' => task.try(:due_date).try(:strftime, "%b %e, %Y"),
              '4' => "#{check_box_tag(%Q(complete-task-#{task.id}), true, task.completed.present?, disabled: task.completed.present?, class: 'complete-task', data: {'task-completed' => task.id})} #{task.try(:completed)}"
          }
      )
    end
    render :json => {aaData: data }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :due_date, :completed, :sms_reminder, :email_reminder, :description,
                                   :estimated_time, :estimated_time_unit, :user_id, :owner_id, :secondary_owner_id, :add_event, :case_id, :calendar_id)
    end
end
