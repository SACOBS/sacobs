require 'spec_helper'

describe Address do


  it { should belong_to(:addressable) }

  it { should validate_presence_of(:street_address1) }
  it { should validate_presence_of(:street_address2) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:postal_code) }
end
