require 'spec_helper'

describe Destination do

  it { should belong_to(:city) }
  it { should belong_to(:route) }

  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:route) }
  it { should validate_presence_of(:sequence) }
  it { should delegate_method(:name).to(:city) }

end