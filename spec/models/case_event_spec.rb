require 'spec_helper'

describe CaseEvent do
  it { should belong_to(:case) }
  it { should belong_to(:event) }
end
