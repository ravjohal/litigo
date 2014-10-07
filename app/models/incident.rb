class Incident < ActiveRecord::Base
  
  INSURANCE_PROVIDERS = ['Allstate', 'State Farm', 'GIECO', 'Progressive', 'AAA', 'American Family', 'Farmers', 'Travelers', 'Esurance', 'Other']

  belongs_to :case
  belongs_to :firm
end
