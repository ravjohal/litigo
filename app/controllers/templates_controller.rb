class TemplatesController < ApplicationController
  require 'docx'
  before_filter :authenticate_user!
  before_action :set_template, only: [:show, :edit, :update, :update_html, :destroy]
  before_action :set_user, :set_firm

  # GET /templates
  # GET /templates.json
  def index
    @templates = @firm.templates
    @template = Template.new
  end

  # GET /templates/1
  # GET /templates/1.json
  def show
  end

  # GET /templates/new
  def new
    @template = Template.new
  end

  # GET /templates/1/edit
  def edit
  end

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(template_params)
    @template.user = @user
    @template.firm = @firm
    if File.extname(@template.file.file.filename) == '.docx'
      content = ''
      doc = Docx::Document.open(@template.file.path)
      doc.paragraphs.each do |p|
        content = content + p.to_html
      end
      @template.html_content = content
    end
    respond_to do |format|
      if @template.save
        format.html { redirect_to @template, notice: 'Template was successfully created.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to @template, notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_html
    respond_to do |format|
      if @template.update(template_params)
        format.json { render json: { success: true, message: "Template saved." } }
      else
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template.destroy
    respond_to do |format|
      format.html { redirect_to templates_url, notice: 'Template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
      params.require(:template).permit(:file, :description, :name, :html_content)
    end
end
