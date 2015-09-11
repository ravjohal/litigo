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
    tmp_file = Htmltoword::Document.create_with_content(Htmltoword::Document.default_xslt_template, template_document.name, template_document.html_content)

    tmp_file

    html_doc = Nokogiri::HTML(template_document.html_content)
    html_root = html_doc.css 'body'

    tmp_file_path = tmp_file.path

    new_tmp_file = Tempfile.new(template_document.name)
    new_tmp_file_name = new_tmp_file.path

    html_root_childs = html_root.children.css('p, hr')

    doc = Docx::Document.open(tmp_file_path)
    doc.paragraphs.each_with_index do |p, index|

      break unless html_root_childs[index]
      html_row_class = html_root_childs[index].attr('class').to_s

      if html_row_class =~ /columns/

        if html_row_class =~ /two_columns/
          wppr = Nokogiri::XML::Node.new('w:pPr', doc.doc)
          w_tabs = Nokogiri::XML::Node.new('w:tabs', doc.doc)
          w_tab1 = Nokogiri::XML::Node.new('w:tab', doc.doc)

          w_tab1['w:val']     = 'right'
          w_tab1['w:pos']     = '8700'
          w_tab1['w:leader']  = 'none'

          w_tabs.add_child w_tab1
          wppr.add_child w_tabs

          p.node.children.first.add_previous_sibling wppr

          if p.node.xpath('w:r').count > 1
            _tmp_second_row = p.node.xpath('w:r')[1].xpath('w:t')[0]

            w_tab_tmp = Nokogiri::XML::Node.new('w:tab', doc.doc)

            _row = p.node.xpath('w:r')[0]
            _row.add_child w_tab_tmp
            _row.add_child _tmp_second_row

            p.node.xpath('w:r')[1].remove
          end

        elsif html_row_class =~ /tab_left_column/
          wppr = Nokogiri::XML::Node.new('w:pPr', doc.doc)
          w_tabs = Nokogiri::XML::Node.new('w:tabs', doc.doc)
          w_tab1 = Nokogiri::XML::Node.new('w:tab', doc.doc)

          w_tab1['w:val']     = 'left'
          w_tab1['w:pos']     = '1000'
          w_tab1['w:leader']  = 'none'

          w_tabs.add_child w_tab1
          wppr.add_child w_tabs

          if p.node.children.count > 0
            p.node.children.first.add_previous_sibling wppr

            w_tab_tmp = Nokogiri::XML::Node.new('w:tab', doc.doc)

            _row = p.node.xpath('w:r')[0]
            _row.children.first.add_previous_sibling w_tab_tmp
          end

        elsif html_row_class =~ /two_left_columns/
          wppr = Nokogiri::XML::Node.new('w:pPr', doc.doc)
          w_tabs = Nokogiri::XML::Node.new('w:tabs', doc.doc)
          w_tab1 = Nokogiri::XML::Node.new('w:tab', doc.doc)

          w_tab1['w:val']     = 'left'
          w_tab1['w:pos']     = '5100'
          w_tab1['w:leader']  = 'none'

          w_tabs.add_child w_tab1
          wppr.add_child w_tabs

          p.node.children.first.add_previous_sibling wppr

          if html_row_class =~ /double_columns/
            if p.node.xpath('w:r').count > 1
              _tmp_second_row = p.node.xpath('w:r')[1].xpath('w:t')[0]

              w_tab_tmp = Nokogiri::XML::Node.new('w:tab', doc.doc)

              _row = p.node.xpath('w:r')[0]
              _row.add_child _tmp_second_row
              _row.add_child w_tab_tmp
              p.node.xpath('w:r')[1].remove

              _tmp_second_row = p.node.xpath('w:r')[1].xpath('w:t')[0]
              _row.add_child _tmp_second_row
              p.node.xpath('w:r')[1].remove

              _tmp_second_row = p.node.xpath('w:r')[1].xpath('w:t')[0]
              _row.add_child _tmp_second_row
              p.node.xpath('w:r')[1].remove
            end
          else
            if p.node.xpath('w:r').count > 1
              _tmp_second_row = p.node.xpath('w:r')[1].xpath('w:t')[0]

              w_tab_tmp = Nokogiri::XML::Node.new('w:tab', doc.doc)

              _row = p.node.xpath('w:r')[0]
              _row.add_child w_tab_tmp
              _row.add_child _tmp_second_row

              p.node.xpath('w:r')[1].remove
            end
          end

        end

      end

    end

    doc.save new_tmp_file_name

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
