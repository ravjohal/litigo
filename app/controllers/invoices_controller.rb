class InvoicesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_invoice, :only => [:edit, :show, :update, :destroy]
  before_action :set_user, :set_firm
  respond_to :html, :xml, :json

  helper DatesHelper
  include DatesHelper

  def index
    respond_to do |format|
      format.html
      format.json { render json: InvoicesDatatable.new(view_context, current_user) }
    end
  end

  def firm_invoices
    respond_to do |format|
      format.json { render json: InvoicesDatatable.new(view_context, current_user) }
    end
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.user = @user
    @invoice.firm = @firm
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoice_path(@invoice), notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def new
    @invoice = Invoice.new
  end

  def edit
  end

  def show
    @payment = Payment.new({invoice: @invoice})
  end

  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { redirect_to invoice_path(@invoice), notice: 'Invoice was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id]) if params[:id]
  end

  def invoice_params
    _params = params.require(:invoice).permit(:case_id, :contact_id, :amount, :status, :due_date, :number, :add_payment_amount)
    _params[:due_date] = convert_date_by_user_timezone(_params[:due_date], @user) if _params[:due_date]
    _params
  end

end
