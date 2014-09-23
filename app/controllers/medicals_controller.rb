class MedicalsController < ApplicationController
  before_filter :authenticate_user!
  before_action :get_case
  before_action :set_user
  # before_action :set_medical, only: [:show, :edit, :update, :destroy]

  # # GET /medicals
  # # GET /medicals.json
  # def index
  #   @medicals = Medical.all
  # end

  # GET /medicals/1
  # GET /medicals/1.json
  def show
    @medical = @case.medical
  end

  # GET /medicals/new
  def new
    @medical = @case.build_medical
  end

  # GET /medicals/1/edit
  def edit
    @medical = @case.medical
  end

  # POST /medicals
  # POST /medicals.json
  def create
    @medical = @case.build_medical(medical_params)

    respond_to do |format|
      if @medical.save
        format.html { redirect_to [@case, @medical], notice: 'Medical was successfully created.' }
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
      format.html { redirect_to medicals_url, notice: 'Medical was successfully destroyed.' }
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
      params.require(:medical).permit(:total_med_bills, :subrogated_amount, :injuries_within_three_days, :length_of_treatment, :length_of_treatment, :doctor_type, :treatment_type, :injuries_attributes => [:injury_type, :region, :code, :created_at, :updated_at, :id])
    end
end
