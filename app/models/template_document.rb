class TemplateDocument < ActiveRecord::Base
  belongs_to :firm
  belongs_to :user
  belongs_to :template

  def generate_docx
    ImportToDocxService.new(name, html_content).generate_docx
  end
end
