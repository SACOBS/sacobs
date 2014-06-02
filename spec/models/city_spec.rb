require 'spec_helper'

describe City, :type => :model do


  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:venues).dependent(:destroy) }

  it { is_expected.to accept_nested_attributes_for(:venues).allow_destroy(true) }
end
