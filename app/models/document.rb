class Document < ActiveRecord::Base
	belongs_to :user
	belongs_to :firm
	belongs_to :lead

	has_many :case_documents, :dependent => :destroy
	has_many :cases, :through => :case_documents
	belongs_to :interrogatory

	mount_uploader :document, DocumentUploader

	before_destroy :clean_s3

	def file_extension
		document.try(:file).try(:extension)
	end

	def can_preview?
		document.try(:file).try(:extension)
	end

	def image?
		%w(png jpg jpeg bmp gif).include? file_extension
	end

	def docx?
		'docx' == file_extension.to_s
	end

	def pdf?
		'pdf' == file_extension.to_s
	end

	def xls?
		%w(xls).include? file_extension
	end

	def txt?
		%w(txt).include? file_extension
	end

	def xlsx?
		%w(xlsx xlsm).include? file_extension
	end

	def tmp_file
		tmp_file = nil
		if document.file
			file_content = document.file.read
			tmp_file = Tempfile.new(document.file.filename, nil, encoding: file_content.encoding )
			tmp_file.write file_content
			tmp_file.close
		end
		tmp_file.try(:path)
	end

	def txt_file
		content = ''
		File.open(tmp_file, 'r').each_line do |line|
			content << "<p>#{line}</p>"
		end
		content
	end

	def pdf_images
		images = []
		pdf = Magick::ImageList.new tmp_file
		tmp_path = Rails.root.join('public', 'tmp')
		#FileUtils::mkdir_p tmp_path
		Dir.mkdir(tmp_path) unless File.exists?(tmp_path)
		pdf.each_with_index { |page_img, i|
			filename = "#{id}_#{i}_pdf_page.jpg"
			page_img.write("#{tmp_path}/#{filename}")
			images << "/tmp/#{filename}"
		}
		images
	end

	def to_docx_html
		content = ''
		doc = Docx::Document.open tmp_file
		doc.paragraphs.each do |p|
			if p.node.xpath('w:r//w:lastRenderedPageBreak').present?
				content << %q(<div class="page-break"></div>) + p.to_html
			else
				content << p.to_html
			end
		end
		content
	end

	def to_xlsx_html
		content = ''
		workbook = Creek::Book.new tmp_file
		workbook.sheets.each do |worksheet|
			table = '<table>'
			worksheet.rows.each do |row|
				table << '<tr>'
				row.each do |key, value|
					table << "<td>#{value}</td>"
				end
				table << '</tr>'
			end
			table << '</table>'
			content << '<div class="page-break"></div>' unless content.blank?
			content << table
		end
		content
	end

	def to_xls_html
		content = ''
		workbook = Spreadsheet.open tmp_file
		workbook.worksheets.each do |worksheet|
			table = '<table>'
			worksheet.rows.each do |row|
				table << '<tr>'
				row.each do |value|
					table << "<td>#{value}</td>"
				end
				table << '</tr>'
			end
			table << '</table>'
			content << '<div class="page-break"></div>' unless content.blank?
			content << table
		end
		content
	end

	private
	  def clean_s3
	    document.remove!
	    #document.thumb.remove! # if you have thumb version or any other version
	  rescue Excon::Errors::Error => error
	    puts "Something has gone wrong"
	    false
	  end
end
