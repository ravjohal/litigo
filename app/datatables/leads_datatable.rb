class LeadsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view
  include ActionView::Helpers::TagHelper
  include DatesHelper

  def initialize(view, user, user_leads)
    @view = view
    @user = user
    @firm = @user.firm
    @user_leads = user_leads
  end

  def as_json(options = {})
    {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: leads.count(:all),
        iTotalDisplayRecords: leads.count(:all),
        aaData: data
    }
  end

  private

  def data
    leads.map do |lead|
      [
          link_to(simple_format_date_regexp(lead.created_at), lead),
          lead.attorney.try(:name),
          lead.name,
          lead.case_type + ": " + lead.sub_type,
          Lead::STATUS[lead.status.to_sym]
      ]
    end
  end

  def leads
    @leads ||= fetch_leads
  end

  def fetch_leads
    #fetch_model = @user_leads ? @user : @firm
    if @user_leads
      leads = @firm.leads.where(attorney_id: @user.id).send(params[:leadsScope])
    else
      leads = @firm.leads.send(params[:leadsScope])
    end

    if params[:iSortCol_0].to_i == 1
      leads = leads.joins(:attorney).order("name #{sort_direction}")
    else
      leads = leads.order("#{sort_column} #{sort_direction}")
    end
    leads = leads.page(page).per_page(per_page)
    if params[:sSearch].present?
      leads = leads.search_lead(params[:sSearch])
    end
    leads
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[created_at attorney first_name estimated_value status]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
  end
end