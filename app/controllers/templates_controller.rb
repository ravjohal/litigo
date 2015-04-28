class TemplatesController < ApplicationController
  require 'docx'
  require 'nokogiri'
  include ActionView::Helpers::FormTagHelper
  include ActionView::Helpers::FormOptionsHelper
  respond_to :docx
  before_filter :authenticate_user!
  before_action :set_template, only: [:show, :edit, :update, :update_html, :destroy, :generate_document, :generate_docx]
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
            content = content + %q(<div class="page-break"></div>) + p.to_html
          else
            content = content + p.to_html
          end

        end
        @template.html_content = content
        respond_to do |format|
          if @template.save
            format.html { redirect_to template_path(@template), notice: 'Template was successfully created.' }
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
      elsif span['data-attr'] == 'prefix'
        span.inner_html = "#{select_tag('prefix', options_for_select(['Mr.', 'Mrs.', 'Ms.', 'Miss.']), :prompt => "Prefix", class: 'custom_input')} <ins></ins>"
      elsif span['data-model'] == 'Custom' && span['data-attr'] == 'input_date'
        span.inner_html = "#{text_field_tag 'input_date', nil, class: 'custom_input'} <ins></ins>"
      elsif span['data-model'] == 'Firm'
        if span['data-attr'] == 'contacts_names'
          span.inner_html = "#{select_tag('firm_contacts_names', options_for_select(@firm.users.map {|user| [user.name.present? ? user.name : user.email, user.name]}), :prompt => "Firm contact", class: 'custom_input firm_contacts_names')} <ins></ins>"
        elsif span['data-attr'] == 'contact_initials'
          span.inner_html = "#{select_tag('firm_contacts_names', options_for_select(@firm.users.map {|user| [user.name.present? ? user.name : user.email, user.initials]}), :prompt => "Firm contact", class: 'custom_input firm_contacts_names')} <ins></ins>"
        else
          span.inner_html = @firm.send(span['data-attr'])
        end
      elsif span['data-model'] == 'Contact'
        contacts = @firm.contacts
        span.inner_html = "#{select_tag("contact_#{span['data-attr']}", options_for_select(contacts.map {|contact| [contact.name.present? ? contact.name : contact.email, try_attr(contact, span['data-attr'].split('.'))]}), :prompt => "Contact #{span['data-attr']}", class: "custom_input contact_#{span['data-attr']}")} <ins></ins>"
      elsif span['data-model'] == 'Company'
        companies = @firm.companies
        span.inner_html = "#{select_tag("company_#{span['data-attr']}", options_for_select(companies.map {|company| [company.name, try_attr(company, span['data-attr'].split('.'))]}), :prompt => "Company #{span['data-attr']}", class: "custom_input company_#{span['data-attr']}")} <ins></ins>"
      end
    end
    @html.to_html
  end

  def get_case
    affair = Case.find(params[:id])
    case_attrs = params[:case_attrs]
    lead_attrs = params[:lead_attrs]
    case_attrs_values = {}
    lead_attrs_values = {}
    if case_attrs.present?
      case_attrs.each do |attr|
        result = try_attr(affair, attr.split('.'))
        case_attrs_values[attr] = result.is_a?(Time) || result.is_a?(Date) ? result.strftime("%B %d, %Y") : result
      end
    end
    if lead_attrs.present?
      lead_attrs.each do |attr|
        result = try_attr(affair.try(:lead), attr.split('.'))
        lead_attrs_values[attr] = result.is_a?(Time) || result.is_a?(Date) ? result.strftime("%B %d, %Y") : result
      end
    end
    contacts_attrs = []
    affair.contacts.each do |contact|
      hash = {
          :id => contact.id,
          :name => contact.name.present? ? contact.name : contact.email,
          :first_name => contact.try(:first_name),
          :last_name => contact.try(:last_name),
          :email => contact.try(:email),
          :phone => contact.try(:phone),
          :address => contact.try(:address),
          :city => contact.try(:city),
          :state => contact.try(:state),
          :zip_code => contact.try(:zip_code),
          :'company.name' => contact.try(:company).try(:zip_code),
          :'company.address' => contact.try(:company).try(:address),
          :'company.city' => contact.try(:company).try(:city),
          :'company.state' => contact.try(:company).try(:state),
          :'company.zipcode' => contact.try(:company).try(:zipcode),
      }

      contacts_attrs.push(hash)
    end

    render :json => { success: true, case_attrs_values: case_attrs_values, lead_attrs_values: lead_attrs_values, contacts: contacts_attrs }
  end

  def get_addressee
    contact = Contact.find(params[:id])
    addressee_attrs = params[:addressee_attrs]
    addressee_attrs_values = {}
    addressee_attrs.each do |attr|
      result = try_attr(contact, attr.split('.'))
      addressee_attrs_values[attr] = result.is_a?(Time) || result.is_a?(Date) ? result.strftime("%B %d, %Y") : result
    end
    render :json => { success: true, addressee_attrs_values: addressee_attrs_values }
  end

  def generate_docx
    template_document = TemplateDocument.create({
                                                    html_content: params[:html],
                                                    name: params[:name].present? ? params[:name] : @template.name.downcase.tr(' ', '_'),
                                                    template_id: @template.id,
                                                    firm_id: @firm.id,
                                                    user_id: @user.id
                                                })
    render :json => { success: true, id: template_document.id }
  end

  def download_docx
    template_document = TemplateDocument.find(params[:id])
    respond_to do |format|
      format.docx do
        render docx: 'download_docx', content: template_document.html_content, filename: template_document.name
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

    def try_attr(model, attrs)
      if attrs.present? && model.present?
        attrs_array = attrs
        result = model.try(attrs_array.shift.to_sym)
        if attrs_array.present?
          try_attr(result, attrs_array)
        else
          return result
        end
      else
        return nil
      end
    end
end
