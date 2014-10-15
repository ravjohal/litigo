require 'spec_helper'

describe CaseTask do
  it { should belong_to(:case) }
  it { should belong_to(:task) }
end
