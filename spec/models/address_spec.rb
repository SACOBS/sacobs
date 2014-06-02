require 'spec_helper'

describe Address, :type => :model do


  it { is_expected.to belong_to(:addressable) }

  it { is_expected.to validate_presence_of(:street_address1) }
  it { is_expected.to validate_presence_of(:street_address2) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:postal_code) }
end
