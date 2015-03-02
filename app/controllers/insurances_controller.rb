class InsurancesController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!
  before_action :get_case
  before_action :set_user, :set_firm

  def show
    @insurance = @case.insurance
  end

  def new
    @insurance = @case.build_insurance
  end

  # GET case/1/insurances/1/edit
  def edit
    # @case = get_case
    @insurance = @case.insurance
  end

  def create
    @insurance = @case.build_insurance(insurance_params)
    @insurance.firm = @firm

    respond_to do |format|
      if @insurance.save
        format.html { redirect_to [@case, @insurance], notice: 'insurance was successfully created.' }
        format.json { render :show, status: :created, location: [@case, @insurance] }
      else
        format.html { render :new }
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /insurances/1
  # PATCH/PUT /insurances/1.json
  def update
    @insurance = @case.insurance

    respond_to do |format|
      if @insurance.update(insurance_params)
        format.html { redirect_to [@case, @insurance], notice: 'insurance was successfully updated.' }
        format.json { render :show, status: :ok, location: @insurance }
      else
        format.html { render :edit }
        format.json { render json: @insurance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @insurance.destroy
    respond_with(@insurance)
  end

  private
    def set_insurance
      @insurance = Insurance.find(params[:id])
    end

    def insurance_params
      params.require(:insurance).permit(:insurance_type, :insurance_provider, :policy_limit, :claim_number, :policy_holder)
    end
end
