class PaymentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  before_action :set_invoice
  respond_to :html, :xml, :json

  def create
    @payment = Payment.new(payment_params)
    @payment.user = @user
    @payment.firm = @firm
    respond_to do |format|
      if @payment.save
        format.html { redirect_to invoice_path(@invoice), notice: 'Payment was successfully added.' }
        format.json { render 'invoices/show', status: :created, location: @invoice }
      else
        format.html { redirect_to invoice_path(@invoice), notice: 'Error while adding payment' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  def index
    @payment = Payment.new(invoice: @invoice)
  end

  def invoice_payments
    respond_to do |format|
      format.json { render json: PaymentsDatatable.new(view_context, current_user, @invoice) }
    end
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:invoice_id]) if params[:invoice_id]
  end

  def payment_params
    params.require(:payment).permit(:amount, :invoice_id, :comment, :date, :number, :sub_type)
  end

end