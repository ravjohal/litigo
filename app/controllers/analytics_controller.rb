class AnalyticsController < ApplicationController

  layout 'analytics', only: [:index]

  def index
  end

  def get_case
    cases = Rails.cache.fetch('analytics_cases', expires_in: 12.hours) do
      res = []
      # Case.closed_cases_scope.find_each {|c| res << c}
      Case.find_each {|c| res << c.analytic_json }
      res
    end
    render json: cases
  end
end
