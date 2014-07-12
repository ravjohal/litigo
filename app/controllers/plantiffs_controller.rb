class PlantiffsController < ApplicationController
  before_action :set_plantiff, only: [:show, :edit, :update, :destroy]
  @user = current_user
  # GET /plantiffs
  # GET /plantiffs.json
  def index
    @plantiffs = Plantiff.all
  end

  # GET /plantiffs/1
  # GET /plantiffs/1.json
  def show
  end

  # GET /plantiffs/new
  def new
    @plantiff = Plantiff.new
  end

  # GET /plantiffs/1/edit
  def edit
  end

  # POST /plantiffs
  # POST /plantiffs.json
  def create
    @plantiff = Plantiff.new(plantiff_params)

    respond_to do |format|
      if @plantiff.save
        format.html { redirect_to @plantiff, notice: 'Plantiff was successfully created.' }
        format.json { render :show, status: :created, location: @plantiff }
      else
        format.html { render :new }
        format.json { render json: @plantiff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plantiffs/1
  # PATCH/PUT /plantiffs/1.json
  def update
    respond_to do |format|
      if @plantiff.update(plantiff_params)
        format.html { redirect_to @plantiff, notice: 'Plantiff was successfully updated.' }
        format.json { render :show, status: :ok, location: @plantiff }
      else
        format.html { render :edit }
        format.json { render json: @plantiff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plantiffs/1
  # DELETE /plantiffs/1.json
  def destroy
    @plantiff.destroy
    respond_to do |format|
      format.html { redirect_to plantiffs_url, notice: 'Plantiff was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plantiff
      @plantiff = Plantiff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plantiff_params
      params.require(:plantiff).permit(:married, :employed, :job_description, :salary, :parent, :felony_convictions, :last_ten_years, :jury_likeability, :contact_attributes => [:first_name, :middle_name, :last_name, :address, :city, :state, :phone_number, :fax_number, :email, :gender, :age, :contactable_id, :contactable_type])
    end
end
