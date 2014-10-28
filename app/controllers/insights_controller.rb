class InsightsController < ApplicationController
  include StatesHelper
  before_action :set_user, :set_firm
  
  before_filter :authenticate_user!
  before_action :set_user, :set_firm
  
  def index
    firm_inj = @firm.injuries
    @injuries = firm_inj.select(:injury_type).where("injury_type != ''").order(injury_type: :asc).distinct
    @regions = firm_inj.select(:region).where("region != ''").order(region: :asc).distinct
    @us_states = us_states
  end

  def filter_cases
    cases = @firm.cases
    render json: cases.to_json(include: [:resolution, :incident, {medical: {include: :injuries}}])
  end

end   