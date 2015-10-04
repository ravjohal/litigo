class MedicalsController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_case
  before_action :set_user, :set_firm
  # before_action :set_medical, only: [:show, :edit, :update, :destroy]

  helper DatesHelper

  # # GET /medicals
  # # GET /medicals.json
  # def index
  #   @medicals = Medical.all
  # end

  # GET /medicals/1
  # GET /medicals/1.json
  def show
    @medical = @case.medical
    @injuries = @medical.injuries.order(:id)
  end

  # GET /medicals/new
  def new
    @medical = @case.build_medical
  end

  # GET /medicals/1/edit
  def edit
    @medical = @case.medical
    @injuries = @medical.injuries.order(:id)
  end

  # POST /medicals
  # POST /medicals.json
  def create
    params[:medical][:doctor_type].delete("")
    @medical = @case.build_medical(medical_params)
    @medical.firm = @firm
    @medical.case = @case
    @medical.user = @user

    respond_to do |format|
      if @medical.save
        format.html { redirect_to [@case, @medical], notice: 'Medicals tab was successfully created.' }
        format.json { render :show, status: :created, location: @medical }
      else
        format.html { render :new }
        format.json { render json: @medical.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medicals/1
  # PATCH/PUT /medicals/1.json
  def update
    @medical = @case.medical
    # if params[:data][:doctor_type]
    #   params[:data][:doctor_type].each do |doc|
    #     doctor_type << doc
    #   end
    #   @medical.data << {:doctor_type => doctor_type}
    # end
    # if params[:treatment_type]
    #   params[:treatment_type].each do |treat|
    #     treatment_type << treat
    #   end
    #   @medical.data << {:treatment_type => treatment_type}
    # end
    # params[:medical][:doctor_type].reject! { |c| c.empty? }
    # params[:medical][:treatment_type].reject! { |c| c.empty? }

    respond_to do |format|
      if @medical.update(medical_params)
        format.html { redirect_to [@case, @medical], notice: 'Medical was successfully updated.' }
        format.json { render :show, status: :ok, location: @medical }
      else
        format.html { render :edit }
        format.json { render json: @medical.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medicals/1
  # DELETE /medicals/1.json
  def destroy
    @medical.destroy
    respond_to do |format|
      format.html { redirect_to medicals_url, notice: 'Medicals tab was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medical
      @medical = @case.medical.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medical_params
      params.require(:medical).permit(:total_med_bills, :subrogated_amount, :injuries_within_three_days, :length_of_treatment, 
                                  :length_of_treatment_unit, :injury_summary, :medical_summary, :final_treatment_date,
                                  :earnings_lost, :treatment_gap, :injections, :hospitalization, :hospital_stay_length, 
                                  :hospital_stay_length_unit, :data, :doctor_type, :treatment_type, :scans_tests,
                                  :medical_bills_attributes => [:services, :provider, :last_date_of_service, :date_of_service, :company_id, :physician_id, :billed_amount, :paid_amount, :account_number, :adjustments, :id, :firm_id, :case_id, :user_id, :_destroy],
                                  :injuries_attributes => [:injury_type, :region, :code, :dominant_side, :joint_fracture,
                                  :displaced_fracture, :disfigurement, :impairment, :permanence, :prior_complaint, :disabled,
                                  :disabled_percent, :surgery, :surgery_count, :surgery_type, :casted_fracture, :ongoing_pain,
                                  :stitches, :future_surgery, :future_medicals, :firm_id, :case_id, :user_id, :id], :doctor_type => [], :treatment_type => [], :scans_tests => [])

    end
end
