class ExpensesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm, :get_case


  # GET /expenses
  # GET /expenses.json
  def index
    @time_entries = @case.try(:time_entries)
    @expenses = @case.try(:expenses) || @firm.try(:expenses)
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(expense_params)
    @expense.firm = @firm
    respond_to do |format|
      if @expense.save
        format.html { redirect_to @case.present? ? case_expense_path(@case, @expense) : @expense, notice: 'Expense was successfully created.' }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1
  # PATCH/PUT /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to @case.present? ? case_expense_path(@case, @expense) : @expense, notice: 'Expense was successfully updated.' }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params[:expense]
      params.require(:expense).permit(:user_id, :created_date, :expense, :aba_billing_code, :amount, :description, :case_id)
    end
end
