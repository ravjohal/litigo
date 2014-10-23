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
    search = Sunspot.search(Case) do
      fulltext params[:state], :fields => :state
      fulltext params[:court], :fields => :court
      fulltext params[:injury_type], :fields => :injury_type
      fulltext params[:region], :fields => :region
      fulltext params[:insurer], :fields => :insurer
    end
    cases = search.results
    render json: cases.to_json(:include => :resolution)
  end

end   