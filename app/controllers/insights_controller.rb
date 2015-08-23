class InsightsController < ApplicationController
  include StatesHelper
  
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  
  def index
    @injuries = Injury.select(:injury_type).where("injury_type != ''").order(injury_type: :asc).distinct
    #puts " IS IT RUNNING THE QUERIES? " + @injuries.to_s
    @regions = Injury.select(:region).where("region != ''").order(region: :asc).distinct
    @us_states = us_states
  end

  def get_counties_by_state
    counties = Case.select(:county).order(county: :asc).distinct
    unless params[:state].blank?
      counties = Case.select(:county).where(state: params[:state]).order(county: :asc).distinct
    end
    render json: counties.to_json
  end

  def filter_cases
    #cases = Case.includes(:resolution).includes(:incident).includes(:contacts).includes(medical: :injuries)
    cases = Case.includes(:resolution)
    unless params[:state].blank?
      cases = cases.where(cases: {state: params[:state]})
    end
    unless params[:county].blank?
      cases = cases.where(cases: {county: params[:county]})
    end
    unless params[:injury_type].blank?
      cases = cases.includes(medical: :injuries)
      cases = cases.where(injuries: {injury_type: params[:injury_type]})

      if params[:injury_type_filter] == "only"
        u2 = Injury.where.not(injury_type: params[:injury_type]).pluck(:medical_id)
        cases = cases.where.not(medicals: {id: u2})
      end
    end
    unless params[:region].blank?
      if params[:injury_type].blank?
        cases = cases.includes(medical: :injuries)
      end
      cases = cases.where(injuries: {region: params[:region]} )
    end
    unless params[:insurer].blank?
      cases = cases.includes(:incident)
      cases = cases.where(incidents: {insurance_provider: params[:insurer]} )
    end
    unless params[:judge].blank?
      cases = cases.includes(:contacts)
      cases = cases.where(contacts: {type: params[:judge]} )
    end

    # puts " CASES from FILTER CASES: " + cases.inspect
    # puts cases.to_sql

    cases = cases.joins(:resolution)
    lines = cases.group('resolutions.resolution_amount').order('resolutions.resolution_amount').count('cases.id')
    pie = cases.group('resolutions.resolution_type').count()
    map = cases.group('cases.state').average("resolutions.resolution_amount")

    # puts " LINES: " + lines.inspect
    # puts " PIE: " + pie.inspect
    # puts " MAP: " + map.inspect
    # puts " CASES SIZE: " + cases.size.to_s

    render json: { 
      totals: cases.size,
      lines: lines,
      pie: pie,
      map: map
    }
  end

end