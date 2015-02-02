class ClientIntakesController < ApplicationController
  before_action :set_client_intake, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm

  # GET /client_intakes
  # GET /client_intakes.json
  def index
    @leads = @firm.leads
    @my_leads = @leads.where(attorney_id: current_user.id)
    @lead = Lead.new
  end

  # GET /client_intakes/1
  # GET /client_intakes/1.json
  def show
  end

  # GET /client_intakes/new
  def new
    @lead = Lead.new
  end

  # GET /client_intakes/1/edit
  def edit
  end

  # POST /client_intakes
  # POST /client_intakes.json
  def create
    @lead = Lead.new(client_intake_params)
    @lead.firm = @firm
    respond_to do |format|
      if @lead.save
        format.html { redirect_to client_intakes_path, notice: 'Client intake was successfully created.' }
        format.json { render :show, status: :created, location: @lead }
      else
        format.html { render :new }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /client_intakes/1
  # PATCH/PUT /client_intakes/1.json
  def update
    respond_to do |format|
      if @lead.update(client_intake_params)
        format.html { redirect_to @lead, notice: 'Client intake was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /client_intakes/1
  # DELETE /client_intakes/1.json
  def destroy
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to client_intakes_url, notice: 'Client intake was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_intake
      @lead = Lead.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_intake_params
      params.require(:lead).permit(:first_name, :last_name)
    end
end
