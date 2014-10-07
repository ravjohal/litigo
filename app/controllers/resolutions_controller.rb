class ResolutionsController < ApplicationController
  before_action :set_resolution, only: [:show, :edit, :update, :destroy]

  def index
    @resolutions = Resolution.all
    respond_with(@resolutions)
  end

  def show
    respond_with(@resolution)
  end

  def new
    @resolution = Resolution.new
    respond_with(@resolution)
  end

  def edit
  end

  def create
    @resolution = Resolution.new(resolution_params)
    @resolution.save
    respond_with(@resolution)
  end

  def update
    @resolution.update(resolution_params)
    respond_with(@resolution)
  end

  def destroy
    @resolution.destroy
    respond_with(@resolution)
  end

  private
    def set_resolution
      @resolution = Resolution.find(params[:id])
    end

    def resolution_params
      params.require(:resolution).permit(:case_id, :firm_id, :settlement_demand, :jury_demand, :resolution_amount, :resolution_type)
    end
end
