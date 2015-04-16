class TemplatesController < ApplicationController
  require 'docx'
  require 'nokogiri'
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  before_filter :authenticate_user!
  before_action :set_template, only: [:show, :edit, :update, :update_html, :destroy, :generate_document]
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
    @templates = @firm.templates
    @template = Template.new(template_params)
    @template.user = @user
    @template.firm = @firm
    if File.extname(@template.file.file.filename) == '.docx'
      content = ''
      if @template.valid_zip?
        doc = Docx::Document.open(@template.file.path)
        doc.paragraphs.each do |p|
          if p.node.xpath('w:r//w:lastRenderedPageBreak').present?
            content = content + %q(<div class="-page-break"></div>) + p.to_html
          else
            content = content + p.to_html
          end

        end
        @template.html_content = content
        respond_to do |format|
          if @template.save
            format.html { redirect_to @template, notice: 'Template was successfully created.' }
            format.json { render :show, status: :created, location: @template }
          else
            format.html { render :new }
            format.json { render json: @template.errors, status: :unprocessable_entity }
          end
        end
      else
        @template.errors.add(:file, 'is corrupted')
        respond_to do |format|
          format.html { render :index }
          format.json { render json: @template.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to template_path(@template), notice: 'Template was successfully updated.' }
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

  def generate_document
    @html = Nokogiri::HTML(@template.html_content.html_safe)
    @html.css(".insertion").each do |span|
      if span['data-model'] == 'Date' && span['data-attr'] == 'today'
        span.inner_html = Date.today.strftime("%B %d, %Y")
        span['class'] = ''
      elsif span['data-model'] == 'Custom' && span['data-attr'] == 'prefix'
        span.inner_html = select_tag('prefix', options_for_select(['Mr.', 'Mrs.', 'Ms.', 'Miss.'], 'Mr.'), class: 'custom_input')
      elsif span['data-model'] == 'Custom' && span['data-attr'] == 'input_date'
        span.inner_html = text_field_tag 'input_date', nil, class: 'custom_input'
      elsif span['data-model'] == 'Firm'
        if span['data-attr'] == 'contacts_names'
          span['class'] = ''
          span.inner_html = select_tag('firm_contacts_names', options_for_select(@firm.users.map {|user| [user.name.present? ? user.name : user.email, user.name]}), class: 'custom_input firm_contacts_names')
        else
          span.inner_html = @firm.send(span['data-attr'])
          span['class'] = ''
        end
      else
        span['class'] = ''
        models = span['data-model'].classify.constantize.where(firm_id: @firm.id)
        span.inner_html = select_tag("#{span['data-model'].downcase}_#{span['data-attr']}", options_for_select(models.map {|model| [model.name, model.id]}), class: "model_input #{span['data-model'].downcase}_#{span['data-attr']}")
      end
    end
    @html.to_html
  end
  
  def get_model
    model_name = params[:model]
    if model_name == 'Firm'
      html = "#{@firm.send(params[:attr])}"
    else
      models = model_name.classify.constantize.where(firm_id: @firm.id)
      html = select_tag('model', options_for_select(models.map {|model| [model.name.present? ? model.name : model.email, model.name]}), class: 'model_input')
    end
    render :json => { success: true, html: html }
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
