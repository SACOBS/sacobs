require 'spec_helper'

describe Charge do
  it { should belong_to(:user) }

  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:percentage) }
end
