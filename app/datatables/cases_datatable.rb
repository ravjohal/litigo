class CasesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  include ActionView::Helpers::TagHelper

  def initialize(view, user)
    @view = view
    @user = user
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Case.count,
        iTotalDisplayRecords: cases.total_entries,
        aaData: data
    }
  end

  private

  def data
    cases.map do |one_case|
      total_med_bills = one_case.medical.present? ? number_to_currency(one_case.medical.total_med_bills, precision: 0) : 0
      [
          link_to(one_case.name, one_case),
          one_case.case_number,
          one_case.case_type,
          total_med_bills,
          content_tag(:div, one_case.description, class: "case-description").html_safe,
          one_case.status
      ]
    end
  end

  def cases
    @cases ||= fetch_cases
  end

  def fetch_cases
    if params[:iSortCol_0].to_i == 3
      cases = @user.cases.joins(:medical).order("total_med_bills #{sort_direction}")
    else
      cases = @user.cases.order("#{sort_column} #{sort_direction}")
    end
    cases = cases.page(page).per_page(per_page)
    if params[:sSearch].present?
      cases = cases.where("name like :search or case_type like :search", search: "%#{params[:sSearch]}%")
    end
    cases
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name case_number case_type total_med_bills description status]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end