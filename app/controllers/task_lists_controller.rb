class TaskListsController < ApplicationController
  before_action :set_task_list, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  respond_to :html, :xml, :json

  def index
    @task_lists = @firm.task_lists
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
    unless @task_list.user == @user || @task_list.amend_permission == 'all_firm' || ['admins', 'admins_attorneys'].include?(@task_list.amend_permission) && @user.is_admin? || @task_list.amend_permission == 'admins_attorneys' && @user.is_attorney?
      redirect_to task_lists_path, alert: "You can't edit this task list."
    end
  end

  def create
    @task_list = TaskList.new(task_list_params)
    @task_list.user = @user
    @task_list.firm = @firm
    respond_to do |format|
      if @task_list.save
        format.html { redirect_to task_lists_path, notice: "Task List was successfully added" }
      else
        format.html { render "new" }
        format.json { render json: @task_list.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    if @task_list.user == @user || @task_list.amend_permission == 'all_firm' || ['admins', 'admins_attorneys'].include?(@task_list.amend_permission) && @user.is_admin? || @task_list.amend_permission == 'admins_attorneys' && @user.is_attorney?
      respond_to do |format|
        if @task_list.update_attributes(task_list_params)
          format.html  { redirect_to task_lists_path, :notice => 'Task List was successfully updated.' }
        else
          format.html  { redirect_to edit_task_list_path(@task_list), :alert => "#{@task_list.errors.full_messages.join('. ')}" }
          format.json  { render :json => @task_list, :status => :unprocessable_entity }
        end
      end
    else
      redirect_to task_lists_path, alert: "You can't edit this task list."
    end
  end

  def destroy
    if @task_list.user == @user || @task_list.amend_permission == 'all_firm' || ['admins', 'admins_attorneys'].include?(@task_list.amend_permission) && @user.is_admin? || @task_list.amend_permission == 'admins_attorneys' && @user.is_attorney?
      @task_list.destroy
    end
    respond_with(@task_list)
  end

  def import_to_case
    if import_to_case_params[:task_lists_ids].blank?
      message = 'Please select task lists to import'
    else
      # affair = Case.find(import_to_case_params[:case_id])
      import_to_case_params[:task_lists_ids].each do |task_list_id|
        task_list = TaskList.find(task_list_id)
        task_list.import_to_case!(import_to_case_params[:case_id], @user.id)
        # task_list.task_drafts.each do |task_draft|
        #   task_attrs = {
        #       name: task_draft.name,
        #       description: task_draft.description,
        #       firm_id: @firm.id,
        #       user_id: @user.id,
        #       conjunction: task_draft.conjunction,
        #       due_term: task_draft.due_term,
        #       anchor_date: task_draft.anchor_date,
        #       due_date: task_draft.return_due_date(affair),
        #       task_draft_id: task_draft.id
        #   }
        #   parent_task = Task.create(task_attrs)
        #   CaseTask.create(case_id: affair.id, task_id: parent_task.id)
        #   if task_draft.children.present?
        #     task_draft.children.each do |child|
        #       child_attrs = {
        #           name: child.name,
        #           description: child.description,
        #           firm_id: @firm.id,
        #           user_id: @user.id,
        #           conjunction: child.conjunction,
        #           due_term: child.due_term,
        #           anchor_date: child.anchor_date,
        #           parent_id: parent_task.id,
        #           due_date: child.return_due_date(affair, parent_task),
        #           task_draft_id: child.id
        #       }
        #       child_task = Task.create(child_attrs)
        #       CaseTask.create(case_id: affair.id, task_id: child_task.id)
        #     end
        #   end
        # end
      end
      message = 'Task list(s) were successfully imported'
    end

    respond_to do |format|
      format.json { render :json => {message: message}, status: :ok }
    end
  end

  private
    def set_task_list
      @task_list = TaskList.find(params[:id])
    end

    def task_list_params
      params.require(:task_list).permit(:name, :view_permission, :amend_permission, :task_import, :case_type, :case_creator,
                                        task_drafts_attributes: [:id, :name, :parent_id, :description, :due_term, :conjunction, :anchor_date, :_destroy,
                                        children_attributes: [:id, :name, :parent_id, :task_list_id, :description, :due_term, :conjunction, :anchor_date, :_destroy]
                                        ])
    end

    def import_to_case_params
      params.require(:task_list).permit(:case_id, :task_lists_ids => [])
    end
end
