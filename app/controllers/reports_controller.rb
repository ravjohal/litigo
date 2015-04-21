class ReportsController < ApplicationController
  before_action :set_user, :set_firm
  
  def index
  end

  def show
  end

  def leads_by_channel_report
  	@start_date = params[:start_date] ? params[:start_date] : Date.today.at_beginning_of_month
  	@end_date = params[:end_date] ? params[:end_date] : Date.today
  	@leads_by_channel_report = LeadsByChannelReport.new(firm_id: @firm.id, start_date: @start_date, end_date: @end_date)
  end

  def leads_detail_report
  	@start_date = params[:start_date] ? params[:start_date] : Date.today.at_beginning_of_month
  	@end_date = params[:end_date] ? params[:end_date] : Date.today
  	@marketing_channel_arg = params[:marketing_channel_arg]
  	@leads_detail_report = LeadsDetailReport.new(firm_id: @firm.id, start_date: @start_date, end_date: @end_date, marketing_channel_arg: @marketing_channel_arg)
  end

  def case_sol_report
  	@start_date = params[:start_date] ? params[:start_date] : Date.today.at_beginning_of_month
  	@end_date = params[:end_date] ? params[:end_date] : Date.today.at_end_of_month
  	puts 'PARAMS ATTORNEY ++++++++++++++ ' + params[:contact][:contact_id].inspect
    @attorney = params[:contact] ? params[:contact][:contact_id]: Attorney.new
    puts 'ATTTORNEY--------------- ' + @attorney.inspect
  	@case_sol_report = CaseSolReport.new(firm_id: @firm.id, start_date: @start_date, end_date: @end_date, attorney_contact_id: @attorney)
  end
end
