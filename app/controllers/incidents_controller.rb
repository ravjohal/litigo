class IncidentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_case

  def show
    @incident = Incident.find(params[:id])
  end

  private

  def get_case
    @case = Case.find(params[:case_id])
  end

end