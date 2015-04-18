class TemplateDocument < ActiveRecord::Base
  belongs_to :firm
  belongs_to :user
  belongs_to :template
end
