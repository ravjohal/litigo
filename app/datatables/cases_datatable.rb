class CasesDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  include ActionView::Helpers::TagHelper

  def initialize(view, user, user_cases)
    @view = view
    @user = user
    @firm = @user.firm
    @user_cases = user_cases
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: cases.count(:all),
        iTotalDisplayRecords: cases.count(:all),
        aaData: data
    }
  end

  private

  def data
    cases.map do |one_case|
      [
          one_case.case_number,
          link_to(one_case.name, one_case),
          one_case.subtype,
          content_tag(:div, one_case.description, class: "table-row-max-h").html_safe,
          one_case.status
      ]
    end
  end

  def cases
    @cases ||= fetch_cases
  end

  def fetch_cases
    #fetch_model = @user_cases ? @user : @firm
    if @user_cases
      cases = @firm.cases.joins(:contacts => [:user]).where(:contacts => {:user_account_id => @user.id}).uniq
    else
      cases = @firm.cases
    end

    if params[:iSortCol_0].to_i == 3
      cases = cases.joins(:medical).order("total_med_bills #{sort_direction}")
    else
      cases = cases.order("#{sort_column} #{sort_direction}")
    end
    cases = cases.page(page).per_page(per_page)
    if params[:sSearch].present?
      cases = cases.search_case(params[:sSearch])
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