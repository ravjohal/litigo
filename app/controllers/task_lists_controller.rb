class TaskListsController < ApplicationController
  before_action :set_task_list, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :set_user, :set_firm

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
  end

  def create
    @task_list = TaskList.new(task_list_params)
    @task_list.save
    respond_with(@task_list)
  end

  def update
    @task_list.update(task_list_params)
    respond_with(@task_list)
  end

  def destroy
    @task_list.destroy
    respond_with(@task_list)
  end

  private
    def set_task_list
      @task_list = TaskList.find(params[:id])
    end

    def task_list_params
      params.require(:task_list).permit(:name)
    end
end
