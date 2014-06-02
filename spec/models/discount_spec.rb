require 'spec_helper'

describe Discount, :type => :model do
  it { is_expected.to belong_to(:passenger_type) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to accept_nested_attributes_for(:passenger_type).allow_destroy(true) }


end