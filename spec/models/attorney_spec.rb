require 'spec_helper'

describe "Attorney" do
  let!(:attorney) { create(:attorney) }

  context "FactoryGirl :attorney" do
    it "works" do
      expect(attorney).to be_valid
    end
  end
end
