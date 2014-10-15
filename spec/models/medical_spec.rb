require 'spec_helper'

describe Medical do
  context 'Relationships' do
    it { should belong_to(:case) }
    it { should have_many(:injuries).dependent(:destroy) }
    it { should belong_to(:firm) }
    it { should accept_nested_attributes_for(:injuries).allow_destroy(true) }
  end

  context 'Validations' do

  end

  context 'Accessible attributes' do
    it { should have_store_accessor(:data) }
    it { should have_store_accessor(:doctor_type) }
    it { should have_store_accessor(:treatment_type) }
  end
end
