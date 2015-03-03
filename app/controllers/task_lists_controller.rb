class TaskListsController < ApplicationController
  before_action :set_task_list, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  respond_to :html, :xml, :json

  def index
    @task_lists = TaskList.all
    respond_with(@task_lists)
  end

  def show
    respond_with(@task_list)
  end

  def new
    @task_list = TaskList.new
    respond_with(@task_list)
  end

  def edit
    @task_drafts = @task_list.task_drafts
    @result = []
    @task_drafts.each do |task|
      @result.push task
      task.children.each do |child|
        @result.push child
      end
    end
  end

  def create
    @task_list = TaskList.new(task_list_params)
    respond_to do |format|
      if @task_list.save
        format.html { redirect_to task_lists_path, notice: "Task List was successfully created." }
      else
        format.html { render action: "new" }
        format.json { render json: @task_list.errors.full_messages.join('. '), :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @task_list.update_attributes(task_list_params)
        format.html  { redirect_to task_lists_path, :notice => 'Task List was successfully updated.' }
      else
        format.html  { redirect_to edit_task_list_path(@task_list), :alert => "#{@task_list.errors.full_messages.join('. ')}" }
        format.json  { render :json => @task_list, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @task_list.destroy
    respond_with(@task_list)
  end

  def destroy_task_draft
    @task_draft = TaskDraft.destroy(params[:id])
  end

  private
    def set_task_list
      @task_list = TaskList.find(params[:id])
    end

    def task_list_params
      params.require(:task_list).permit(:name, :view_permission, :amend_permission, :task_import,
                                        task_drafts_attributes: [:id, :name, :parent_id, :description, :due_term, :conjunction, :anchor_date, :_destroy,
                                        children_attributes: [:id, :name, :parent_id, :task_list_id, :description, :due_term, :conjunction, :anchor_date, :_destroy]
                                        ])
    end
end
