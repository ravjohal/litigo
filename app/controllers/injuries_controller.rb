class InjuriesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_injury, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm

  # GET /injuries
  # GET /injuries.json
  # def index
  #   @injuries = Injury.all
  # end

  # # GET /injuries/1
  # # GET /injuries/1.json
  # def show
  # end

  # # GET /injuries/new
  def new
    @injury = Injury.new
    @medical = get_medical
    new_injury = [@medical, @injury]
  end

  # # GET /injuries/1/edit
  # def edit
  # end

  # POST /injuries
  # POST /injuries.json
  def create

    @medical = get_medical
    @case = @medical.case

    @injury = @medical.injuries.create(injury_params)
    @injury.firm = @firm

    respond_to do |format|
      if @injury.save
        format.html { redirect_to case_medical_path(@case, @medical), notice: 'Injury was successfully created.' }
        format.json { render :show, status: :created, location: [@case, @medical] }
      else
        format.html { render :new }
        format.json { render json: @injury.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /injuries/1
  # PATCH/PUT /injuries/1.json
  def update
    respond_to do |format|
      if @injury.update(injury_params)
        format.html { redirect_to @injury, notice: 'Injury was successfully updated.' }
        format.json { render :show, status: :ok, location: @injury }
      else
        format.html { render :edit }
        format.json { render json: @injury.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /injuries/1
  # DELETE /injuries/1.json
  def destroy
    @injury.destroy
    respond_to do |format|
      format.html { redirect_to injuries_url, notice: 'Injury was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_injury
      @injury = Injury.find(params[:id])
    end

    def get_medical
      if params[:medical_id]
        @medical = Medical.find(params[:medical_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def injury_params
      params.require(:injury).permit(:injury_type, :region, :code, :dominant_side, :joint_fracture,
                                  :displaced_fracture, :disfigurement, :impairment, :permanence, :prior_complaint, :disabled,
                                  :disabled_percent, :surgery, :surgery_count, :surgery_type, :casted_fracture,
                                  :stitches, :future_surgery, :future_medicals)
    end
end
