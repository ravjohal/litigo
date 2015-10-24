class PaymentsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  include ActionView::Helpers::TagHelper
  include DatesHelper

  def initialize(view, user, invoice)
    @view = view
    @user = user
    @invoice = invoice
    @firm = @user.firm
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: payments.count(:all),
        iTotalDisplayRecords: payments.count(:all),
        aaData: data
    }
  end

  private

  def data
    payments.map do |payment|
      [
          payment.number,
          number_to_currency(payment.amount),
          simple_format_date_regexp(payment.created_at),
          simple_format_date_regexp(payment.date),
          payment.comment
      ]
    end
  end

  def payments
    @payments ||= fetch_leads
  end

  def fetch_leads

    invoices = @invoice.payments

    invoices = invoices.order("#{sort_column} #{sort_direction}")

    invoices = invoices.page(page).per_page(per_page)
    if params[:sSearch].present?
      invoices = invoices.search_payment(params[:sSearch])
    end
    invoices
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[number amount created_at date comment]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end