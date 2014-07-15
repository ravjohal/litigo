class CasesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_case, only: [:show, :edit, :update, :destroy]

  # GET /cases
  # GET /cases.json
  def index
    @user = current_user

    @cases = Case.unscoped
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

  # GET /cases/1
  # GET /cases/1.json
  def show
    @user = current_user
  end

  # GET /cases/new
  def new
    @user = current_user
    @case = Case.new
  end

  # GET /cases/1/edit
  def edit
    @user = current_user
  end

  # POST /cases
  # POST /cases.json
  def create
    @user = current_user
    @case = Case.new(case_params)

    @case.user = @user

    respond_to do |format|
      if @case.save
        format.html { redirect_to @case, notice: 'Case was successfully created.' }
        format.json { render :show, status: :created, location: @case }
      else
        format.html { render :new }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cases/1
  # PATCH/PUT /cases/1.json
  def update
    @user = current_user

    @case.user = @user
    
    respond_to do |format|
      if @case.update(case_params)
        format.html { redirect_to @case, notice: 'Case was successfully updated.' }
        format.json { render :show, status: :ok, location: @case }
      else
        format.html { render :edit }
        format.json { render json: @case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cases/1
  # DELETE /cases/1.json
  def destroy
    @user = current_user
    @case.destroy
    respond_to do |format|
      format.html { redirect_to cases_url, notice: 'Case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_case
    @user = current_user
    @case = Case.new
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_case
      @case = Case.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def case_params
      params.require(:case).permit(:name, :number, :description, :case_type, :subtype, :medical_bills)
    end
end
