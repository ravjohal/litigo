class InterrogatoriesController < ApplicationController
  respond_to :html, :json
  before_filter :authenticate_user!
  before_action :get_case
  before_action :set_user, :set_firm
  before_action :set_interrogatory, only: [:show, :edit, :update, :destroy]


  # GET /interrogatories/1
  # GET /interrogatories/1.json
  def show
    @interrogatory = @case.interrogatory
    @interrogatory_children = @case.interrogatory.children
  end

  # GET /interrogatories/new
  def new
    @interrogatory = @case.build_interrogatory
  end

  # GET /interrogatories/1/edit
  def edit
    @interrogatory = @case.interrogatory
  end

  def index
    @interrogatories = @case.interrogatories
  end

  def edit_case_interrogatories
    @case = Case.find(params[:id])
    @interrogatories = @case.interrogatories
    @fly_creation = Contact.new
  end

  # POST /interrogatories
  # POST /interrogatories.json
  def create
    @interrogatory = @case.build_interrogatory(interrogatory_params)
    @interrogatory.firm = @firm
    @interrogatory.user = @user

    respond_to do |format|
      if @interrogatory.save
        format.html { redirect_to [@case, @interrogatory], notice: 'Interrogatory was successfully created.' }
        format.json { render :show, status: :created, location: [@case, @interrogatory] }
      else
        format.html { render :new }
        format.json { render json: @interrogatory.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interrogatories/1
  # PATCH/PUT /interrogatories/1.json
  def update
    @interrogatory = @case.interrogatory

    respond_to do |format|
      if @interrogatory.update(interrogatory_params)
        format.html { redirect_to [@case, @interrogatory], notice: 'Interrogatory was successfully updated.' }
        format.json { render :show, status: :ok, location: @interrogatory }
      else
        format.html { render :edit }
        format.json { render json: @interrogatory.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interrogatories/1
  # DELETE /interrogatories/1.json
  def destroy
    @interrogatory.destroy
    respond_with(@interrogatory)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interrogatory
      @interrogatory = Interrogatory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interrogatory_params
      params.require(:interrogatory).permit(:question, :response, :requester_id, :responder_id, :document, :firm_id, :case_id, :created_by, :last_updated_by, :parent_id, :rep_date, :req_date,
                                            :document_attributes => [:document, :id, :author, :firm_id, :user_id, {:case_ids => []}, :doc_type])
    end
end
