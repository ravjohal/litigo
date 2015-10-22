class AnalyticsController < ApplicationController

  layout 'analytics', only: [:index]

  def index
  end

  def get_case
    #cases = Rails.cache.fetch('analytics_cases', expires_in: 12.hours) {analytics_info}
    cases = analytics_info
    render json: cases
  end

  private
  def analytics_info
    res = []
    Case.closed_cases_scope.find_each {|c| res << c.analytic_json}
    res
  end
end
