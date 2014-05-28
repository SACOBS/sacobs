require 'spec_helper'

describe City do


  it { should belong_to(:user) }
  it { should have_many(:venues).dependent(:destroy) }

  it { should accept_nested_attributes_for(:venues).allow_destroy(true) }
end
