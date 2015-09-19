class SettlementsController < ApplicationController
  before_action :set_settlement, only: [:show, :edit, :update, :destroy, :generate_docx]
  before_action :set_user, :set_firm

  # GET /settlements
  # GET /settlements.json
  def index
    @settlements = Settlement.all
  end

  # GET /settlements/1
  # GET /settlements/1.json
  def show
  end

  # GET /settlements/new
  def new
    unless get_case
      redirect_to documents_path
      return
    end

    @settlement = Settlement.find_or_initialize_by case_id: params[:case_id]

    @settlement.user = @user
    @settlement.firm = @firm
    @settlement.case = @case
    @settlement.save

    @html = @settlement.fill_generated_html
  end

  # GET /settlements/1/edit
  def edit
    @settlement = Settlement.find_by case_id: params[:case_id]
    @settlement ||= Settlement.new(case_id: case_id)

    @settlement.user = @user
    @settlement.firm = @firm

    @html = Nokogiri::HTML(@settlement.html_content.html_safe)
  end

  # POST /settlements
  # POST /settlements.json
  def create
    @settlement = Settlement.new(settlement_params)

    respond_to do |format|
      if @settlement.save
        format.html { redirect_to @settlement, notice: 'Settlement was successfully created.' }
        format.json { render :show, status: :created, location: @settlement }
      else
        format.html { render :new }
        format.json { render json: @settlement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settlements/1
  # PATCH/PUT /settlements/1.json
  def update
    respond_to do |format|
      if @settlement.update(settlement_params)
        format.html { redirect_to @settlement, notice: 'Settlement was successfully updated.' }
        format.json { render :show, status: :ok, location: @settlement }
      else
        format.html { render :edit }
        format.json { render json: @settlement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settlements/1
  # DELETE /settlements/1.json
  def destroy
    @settlement.destroy
    respond_to do |format|
      format.html { redirect_to settlements_url, notice: 'Settlement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def generate_docx
    template_document = TemplateDocument.create({
                                                    html_content: params[:html],
                                                    name: 'Settlement_Statement',
                                                    template_id: @settlement.template_id,
                                                    firm_id: @firm.id,
                                                    user_id: @user.id
                                                })
    render :json => { success: true, id: template_document.id }
  end

  def download_docx
    template_document = TemplateDocument.find(params[:id])
    new_tmp_file_name = template_document.generate_docx
    respond_to do |format|
      format.docx do
        send_file new_tmp_file_name, :filename => "#{template_document.name}.docx"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_settlement
      @settlement = Settlement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def settlement_params
      params[:settlement]
    end
end
