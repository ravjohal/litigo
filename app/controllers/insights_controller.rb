class InsightsController < ApplicationController
  include StatesHelper
  
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  
  def index
    @injuries = Injury.select(:injury_type).where("injury_type != ''").order(injury_type: :asc).distinct
    @regions = Injury.select(:region).where("region != ''").order(region: :asc).distinct
    @us_states = us_states
  end

  def filter_cases
    cases = Case.includes(:resolution).includes(:incident).includes(medical: :injuries)
    unless params[:state].blank?
      cases = cases.where(cases: {state: params[:state]})
    end
    unless params[:court].blank?
      cases = cases.where(cases: {court: params[:court]})
    end
    unless params[:injury_type].blank?
      cases = cases.where(injuries: {injury_type: params[:injury_type]} )
    end
    unless params[:region].blank?
      cases = cases.where(injuries: {region: params[:region]} )
    end
    unless params[:insurer].blank?
      cases = cases.where(incidents: {insurance_provider: params[:insurer]} )
    end

    pie = cases.joins(:resolution).group('resolutions.resolution_type').count()
    map = cases.joins(:resolution).group('cases.state').average("resolutions.resolution_amount")

    render json: { 
      lines: cases.to_json(
                include: {
                  :resolution => {
                    only: [:resolution_amount]
                  }
                }, 
                only: [:state, :court]
              ),
      pie: pie,
      map: map
    }
  end

end