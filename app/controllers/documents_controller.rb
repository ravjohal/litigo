class DocumentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_firm

  # GET /documents
  # GET /documents.json
  def index
    if get_case
      @documents = @case.documents
      @new_path = new_case_document_path(@case)
      @documents_a = [@case, Document.new] #for modal partial rendering
    else
      @documents = @firm.documents
      @new_path = new_document_path
      @documents_a = Document.new #for modal partial rendering
    end
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    @document = Document.find(params[:id])
    restrict_access("documents") if @document.firm_id != @firm.id   
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
    @document = Document.find(params[:id])
    restrict_access("documents") if @document.firm_id != @firm.id 
    if get_case
      @documents_a = [@case, @document] #for modal partial rendering
    else
      @documents_a = @document #for modal partial rendering
    end
  end

  # POST /documents
  # POST /documents.json
  def create
    if get_case
      @document = @case.documents.create(document_params)
      path_documents = case_documents_path
    else
      @document = Document.new(document_params)
      path_documents = documents_path
    end

    @document.user = @user
    @document.firm = @firm

    respond_to do |format|
      if @document.save
        format.html { redirect_to path_documents, notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update

     if get_case
      #@document = @case.documents.create(document_params)
      path_documents = case_documents_path
    else
      #@document = @document(document_params)
      path_documents = documents_path
    end

    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to path_documents, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:author, :doc_type, :user_id, :template, :document, :case_ids => [])
    end
end
