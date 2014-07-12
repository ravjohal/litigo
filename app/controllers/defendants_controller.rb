class DefendantsController < ApplicationController
  before_action :set_defendant, only: [:show, :edit, :update, :destroy]
  @user = current_user
  # GET /defendants
  # GET /defendants.json
  def index
    @defendants = Defendant.all
  end

  # GET /defendants/1
  # GET /defendants/1.json
  def show
  end

  # GET /defendants/new
  def new
    @defendant = Defendant.new
  end

  # GET /defendants/1/edit
  def edit
  end

  # POST /defendants
  # POST /defendants.json
  def create
    @defendant = Defendant.new(defendant_params)

    respond_to do |format|
      if @defendant.save
        format.html { redirect_to @defendant, notice: 'Defendant was successfully created.' }
        format.json { render :show, status: :created, location: @defendant }
      else
        format.html { render :new }
        format.json { render json: @defendant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /defendants/1
  # PATCH/PUT /defendants/1.json
  def update
    respond_to do |format|
      if @defendant.update(defendant_params)
        format.html { redirect_to @defendant, notice: 'Defendant was successfully updated.' }
        format.json { render :show, status: :ok, location: @defendant }
      else
        format.html { render :edit }
        format.json { render json: @defendant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /defendants/1
  # DELETE /defendants/1.json
  def destroy
    @defendant.destroy
    respond_to do |format|
      format.html { redirect_to defendants_url, notice: 'Defendant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_defendant
      @defendant = Defendant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def defendant_params
      params.require(:defendant).permit(:married, :employed, :job_description, :salary, :parent, :felony_convictions, :last_ten_years, :jury_likeability, :contact_attributes => [:first_name, :middle_name, :last_name, :address, :city, :state, :phone_number, :fax_number, :email, :gender, :age, :contactable_id, :contactable_type])
    end
end
