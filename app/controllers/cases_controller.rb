class CasesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_case, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @cases = @user.cases
    #@cases = Case.all #if you want to grab all tenant's (firm) cases
    if params[:order] && ["asc", "desc"].include?(params[:sort_mode])
      order = params[:order].split(",").map {|o| "#{o} #{params[:sort_mode]}" }.join(", ")
      @cases = @cases.order(order)
    end
    if params[:search].present? && params[:utf8] == "✓"
      logger.info"#{params[:search]}"
      @cases = @cases.search(params[:search])

    end
    @cases = @cases.paginate(:per_page => 10, :page => params[:page])
  end

  def show
  end

  def new
   @case = Case.new
  end

  def edit
  end

  def create
    @case = Case.new(case_params)
    @case.user = @user
    if @case.save
      redirect_to @case, notice: 'Case was successfully created.'
    else
      render :new
    end

  end

  def update
    @case.user = @user
    if @case.update(case_params)
      redirect_to @case, notice: 'Case was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @case.destroy
    redirect_to cases_url, notice: 'Case was successfully destroyed.'
  end

  private
    def set_case
      @case = Case.find(params[:id])
    end

    def case_params
      params.require(:case).permit(:name, :number, :description, :case_type, :subtype,
                                  :court, :plaintiff, :defendant, :corporation, :status,
                                  :creation_date, :closing_date, :state,
                                  :medical_bills, :event_ids => [], :task_ids => [], :document_ids => [])
    end
end
