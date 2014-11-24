class TasksController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm

  # GET /tasks
  # GET /tasks.json
  def index
    if get_case
      @tasks = @case.tasks
      @new_path = new_case_task_path(@case)
      @tasks_a = [@case, Task.new] #for modal partial rendering
    else
      @tasks = @firm.tasks
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
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :due_date, :completed, :sms_reminder, :email_reminder, :description, :user_id, :case_ids => [])
    end
end
