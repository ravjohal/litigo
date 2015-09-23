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
		'xls' == file_extension.to_s
	end

	def pdf_images
		images = []
		pdf = Magick::ImageList.new(document.file.path)
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
		doc = Docx::Document.open(document.file.path)
		doc.paragraphs.each do |p|
			if p.node.xpath('w:r//w:lastRenderedPageBreak').present?
				content << %q(<div class="page-break"></div>) + p.to_html
			else
				content << p.to_html
			end
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
