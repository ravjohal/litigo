class TreatmentsController < ApplicationController
  before_action :set_treatment, only: [:show, :edit, :update, :destroy]

  def index
    @treatments = Treatment.all
    respond_with(@treatments)
  end

  def show
    respond_with(@treatment)
  end

  def new
    @treatment = Treatment.new
    respond_with(@treatment)
  end

  def edit
  end

  def create
    @treatment = Treatment.new(treatment_params)
    @treatment.save
    respond_with(@treatment)
  end

  def update
    @treatment.update(treatment_params)
    respond_with(@treatment)
  end

  def destroy
    @treatment.destroy
    respond_with(@treatment)
  end

  private
    def set_treatment
      @treatment = Treatment.find(params[:id])
    end

    def treatment_params
      params.require(:treatment).permit(:injury_id, :firm_id, :surgery, :surgery_count, :surgery_type, :casted_fracture, :stitches, :future_surgery, :future_medicals)
    end
end
