class ResolutionsController < ApplicationController
  before_action :set_resolution, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  before_action :get_case
  before_action :set_user, :set_firm
  respond_to :html


  def show
    @resolution = @case.resolution
  end

  def new
    @resolution = @case.build_resolution
    respond_with(@resolution)
  end

  def edit
    @resolution = @case.resolution
  end

  def create
    @resolution = @case.build_resolution(resolution_params)
    @resolution.firm = @firm
    @resolution.save
    respond_with([@case, @resolution])
  end

  def update
    @resolution = @case.resolution
    
    #@resolution.update(resolution_params)
    #respond_with([@case, @resolution])

    respond_to do |format|
      if @resolution.update(resolution_params)
        format.html { redirect_to [@case, @resolution], notice: 'resolution was successfully updated.' }
        format.json { render :show, status: :ok, location: @resolution }
      else
        format.html { render :edit }
        format.json { render json: @resolution.errors, status: :unprocessable_entity }
      end
    end
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
