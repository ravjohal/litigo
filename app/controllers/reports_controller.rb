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
    @marketing_channel_id_array = Lead::CHANNELS
  	@marketing_channel_arg = params[:marketing_channel_arg] && params[:marketing_channel_arg] != '' ? params[:marketing_channel_arg].split(",") : @marketing_channel_id_array
    @selected_marketing_channel = params[:marketing_channel_arg] if params[:marketing_channel_arg]
  	@leads_detail_report = LeadsDetailReport.new(firm_id: @firm.id, start_date: @start_date, end_date: @end_date, marketing_channel_arg: @marketing_channel_arg)
  end

  def case_sol_report
  	@start_date = params[:start_date] ? params[:start_date] : Date.today.at_beginning_of_month
  	@end_date = params[:end_date] ? params[:end_date] : Date.today.at_end_of_month
  	#puts 'PARAMS ATTORNEY ++++++++++++++ ' + params[:contact][:contact_id].inspect
    @attorney_staff_all_id_array = @firm.contacts.where("type IN ('Attorney', 'Staff')").pluck(:id)
    @attorney_staff = params[:contact] && params[:contact][:contact_id] != '' ? params[:contact][:contact_id].split(",").map(&:to_i) : @attorney_staff_all_id_array
    @selected_attorney = params[:contact][:contact_id] if params[:contact]
    #puts 'ATTTORNEY--------------- ' + @attorney.inspect
  	@case_sol_report = CaseSolReport.new(firm_id: @firm.id, start_date: @start_date, end_date: @end_date, attorney_contact_id: @attorney_staff)
  end

  def open_close_report
    @start_date = params[:start_date] ? params[:start_date] : Date.today.at_beginning_of_month
    @end_date = params[:end_date] ? params[:end_date] : Date.today.at_end_of_month
    @open_closed = params[:open_closed] ? params[:open_closed] : "Opened"
    @open_close_report = OpenCloseReport.new(firm_id: @firm.id, start_date: @start_date, end_date: @end_date, open_closed: @open_closed)
  end

  def medical_bills_report
    @case_all_id_array = @firm.cases.pluck(:id)
    @case_ = params[:case] && params[:case][:case_id] != '' ? params[:case][:case_id].split(",").map(&:to_i) : @case_all_id_array
    @selected_case = params[:case][:case_id] if params[:case]
    @medical_bills_report = MedicalBillsReport.new(firm_id: @firm.id, case_id_as_criteria: @case_)
  end

   def cases_by_user_report
    @user_all_id_array = []
    @firm.contacts.where("type IN ('Attorney', 'Staff')").each do |contact| 
      if User.exists?(contact.user_account_id)
        @user_all_id_array << contact.user_account_id 
      end
    end 
    @user_ = params[:contact] && params[:contact][:contact_id] != '' ? params[:contact][:contact_id].split(",").map(&:to_i) : @user_all_id_array.uniq
    @selected_user = params[:contact][:contact_id] if params[:contact]
    @statuses = params[:status] ? params[:status] : Case::STATUS
    #puts 'ATTTORNEY--------------- ' + @user_.inspect
    @cases_by_user_report = CasesByUserReport.new(firm_id: @firm.id, user_contact_id: @user_, status: @statuses)
  end

  def cases_by_status_report
    @case_status_id_array = Case::STATUS
    @case_status_arg = params[:case_status_arg] && params[:case_status_arg] != '' ? params[:case_status_arg].split(",") : @case_status_id_array
    @selected_case_status = params[:case_status_arg] if params[:case_status_arg]
    @cases_by_status_report = CasesByStatusReport.new(firm_id: @firm.id, case_status_arg: @case_status_arg)
  end

  def open_close_detail_report
    @start_date = params[:start_date] ? params[:start_date] : Date.today.at_beginning_of_month
    @end_date = params[:end_date] ? params[:end_date] : Date.today.at_end_of_month
    #puts 'PARAMS ATTORNEY ++++++++++++++ ' + params[:contact][:contact_id].inspect
    @open_close_detail_report = OpenCloseDetailReport.new(firm_id: @firm.id, start_date: @start_date, end_date: @end_date)
  end

  def count_of_cases_by_status_report
    all_statuses = Case::STATUS
    all_statuses.delete("Closed")
    all_statuses.delete("Inactive")
    open_statuses = all_statuses
    @open_count = Case.where(:firm_id => @firm.id, :status => open_statuses).count
    @closed_count = Case.where(:firm_id => @firm.id, :status =>  ['Inactive', 'Closed']).count
    
    @count_of_cases_by_status_report = CountOfCasesByStatusReport.new(firm_id: @firm.id)
  end  
end
