require 'spec_helper'

describe Destination, :type => :model do

  it { is_expected.to belong_to(:city) }
  it { is_expected.to belong_to(:route) }

  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:route) }
  it { is_expected.to validate_presence_of(:sequence) }
  it { is_expected.to delegate_method(:name).to(:city) }

end