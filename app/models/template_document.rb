class TemplateDocument < ActiveRecord::Base
  belongs_to :firm
  belongs_to :user
  belongs_to :template

  def generate_docx
    tmp_file = Htmltoword::Document.create_with_content(Htmltoword::Document.default_xslt_template, self.name, self.html_content)

    tmp_file

    html_doc = Nokogiri::HTML(self.html_content)
    html_root = html_doc.css 'body'

    tmp_file_path = tmp_file.path

    new_tmp_file = Tempfile.new(self.name)
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

    new_tmp_file_name
  end
end
