class InvoicesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  include ActionView::Helpers::TagHelper
  include DatesHelper

  def initialize(view, user)
    @view = view
    @user = user
    @firm = @user.firm
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: invoices.count(:all),
        iTotalDisplayRecords: invoices.count(:all),
        aaData: data
    }
  end

  private

  def data
    invoices.map do |invoice|
      [
          link_to(invoice.number, invoice),
          invoice.contact.try(:name),
          invoice.case.try(:name),
          simple_format_date_regexp(invoice.due_date),
          number_to_currency(invoice.amount),
          number_to_currency(invoice.balance),
          Invoice::STATUS[invoice.status.to_sym]
      ]
    end
  end

  def invoices
    @payments ||= fetch_leads
  end

  def fetch_leads

    invoices = @firm.payments

    if params[:iSortCol_0].to_i == 1
      invoices = invoices.joins(:contact).order("name #{sort_direction}")
    elsif params[:iSortCol_0].to_i == 2
      invoices = invoices.joins(:case).order("name #{sort_direction}")
    else
      invoices = invoices.order("#{sort_column} #{sort_direction}")
    end

    invoices = invoices.page(page).per_page(per_page)
    if params[:sSearch].present?
      invoices = invoices.search_invoice(params[:sSearch])
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
    columns = %w[number contact case due_date amount balance status]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end