require 'spec_helper'

describe Case do

  let!(:user) { create(:user) }
  let!(:attorney) { create(:attorney, :attorney_type => 'Lawyer') }
  let!(:contact) { create(:contact, :first_name=> 'John', :last_name => 'Doh') }
  let!(:cas) { create(:case, case_number: 7, case_type: 'CType', subtype: 'SubType', name: 'Case1',
                       description: 'Description') }
  let!(:event) { create(:event) }
  let!(:doc) { create(:document) }
  let!(:task) { create(:task) }

  context 'Relationships' do
    # it { should define_enum_for(:status) }
    it { should have_many(:contacts) }
    it { should have_one(:incident).dependent(:destroy) }
    it { should have_one(:medical).dependent(:destroy) }
    it { should have_one(:resolution).dependent(:destroy) }
    it { should belong_to(:user) }
    it { should belong_to(:firm) }
    it { should have_many(:case_documents).dependent(:destroy) }
    it { should have_many(:documents).through(:case_documents) }
    it { should have_many(:case_tasks).dependent(:destroy) }
    it { should have_many(:tasks).through(:case_tasks) }
    it { should have_many(:case_events).dependent(:destroy) }
    it { should have_many(:events).through(:case_events) }
    it { should have_many(:notes) }
    it { should accept_nested_attributes_for(:documents) }
    it { should accept_nested_attributes_for(:medical).allow_destroy(true)}
    it { should accept_nested_attributes_for(:incident).allow_destroy(true)}
    it { should accept_nested_attributes_for(:resolution).allow_destroy(true)}
  end

  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:case_number) }
    it { should validate_presence_of(:case_type) }
    it { should validate_presence_of(:subtype) }
    it { should allow_value('fi', 'ki', '').for(:state)}
    it { should_not allow_value('fii', 'kii', '123').for(:state)}
    context 'if self.closed?' do
      before { subject.stub(:closed?) { true } }
      xit { should validate_presence_of(:closing_date) }
    end
    context 'if self.pending?' do
      before { subject.stub(:pending?) { true } }
      xit { should validate_absence_of(:closing_date) }
    end
    context 'if self.open?' do
      before { subject.stub(:open?) { true } }
      xit { should validate_absence_of(:closing_date) }
    end
  end

  context 'Accessible attributes' do
    it { should respond_to(:name, :case_number, :description, :medical_bills, :case_type, :subtype, :user_id, :state, :court, :firm_id, :county, :docket_number, :contacts, :incident) }
  end

end
