# == Schema Information
#
# Table name: cities
#
#  id   :integer          not null, primary key
#  name :string(255)
#

require 'spec_helper'

describe City do
  let(:city) { build(:city) }
  subject { city }

  it { should be_valid }
  it { should validate_presence_of(:name) }
end
