class Insurance < ActiveRecord::Base
  INSURANCE_PROVIDERS = ['Allstate', 'State Farm', 'GIECO', 'Progressive', 'AAA', 'American Family', 'Mercury', 'Nationwide', 'Farmers', 'Travelers', 'Esurance', 'Self-insured', 'Other']

  belongs_to :case
  belongs_to :firm
end
