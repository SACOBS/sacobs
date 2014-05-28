require 'spec_helper'

describe Bank do

  it { should validate_presence_of(:name) }
end
