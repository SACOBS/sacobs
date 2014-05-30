require 'spec_helper'

describe Discount do
  it { should belong_to(:passenger_type) }
  it { should belong_to(:user) }
  it { should accept_nested_attributes_for(:passenger_type).allow_destroy(true) }


end