class InvoicesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_invoice, :only => [:edit, :show, :update, :destroy, :download]
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

  def expenses
    @expenses = Expense.where(:id => params[:ids])
    render partial: 'expenses_table_for_form'
  end

  def services
    @services = TimeEntry.where(:id => params[:ids])
    render partial: 'services_table_for_form'
  end

  def invoice_sum
    expenses_ids = params[:expenses_ids] || []
    services_ids = params[:services_ids] || []

    services_sum = TimeEntry.where(id: services_ids).inject(0) {|sum, te| sum += te.html_amount.to_f }
    expenses_sum = Expense.where(id: expenses_ids).sum(:amount)

    @sum = services_sum.to_f + expenses_sum.to_f

    render json: {sum: @sum, html: render_to_string(partial: 'invoice_sum')}
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
    @invoice = Invoice.new({firm: @firm, user: @user})
  end

  def edit
  end

  def show
    @payment = Payment.new({invoice: @invoice})
    render (@invoice.draft? ? :show_draft : :show)
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

  def download
    new_tmp_file_name = @invoice.generate_docx(render_to_string(partial: 'invoices/template_block'))
    send_file new_tmp_file_name, :filename => "Invoice##{@invoice.number}.docx"
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id]) if params[:id]
    @invoice ||= Invoice.find(params[:invoice_id]) if params[:invoice_id]
  end

  def invoice_params
    _params = params.require(:invoice).permit(:case_id, :contact_id, :amount, :status, :due_date, :number, :expenses_ids, :time_entries_ids)
    _params[:expenses_ids] = _params[:expenses_ids].split(',') if _params[:expenses_ids]
    _params[:time_entries_ids] = _params[:time_entries_ids].split(',') if _params[:time_entries_ids]
    _params
  end

end
