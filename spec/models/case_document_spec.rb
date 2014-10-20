require 'spec_helper'

describe CaseDocument do
  it { should belong_to(:case) }
  it { should belong_to(:document) }
end
