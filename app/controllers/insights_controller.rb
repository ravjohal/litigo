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
    cases = Case.all
    render json: cases.to_json(include: [:resolution, :incident, {medical: {include: :injuries}}])
  end

end   