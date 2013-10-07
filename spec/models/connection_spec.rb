# == Schema Information
#
# Table name: connections
#
#  id           :integer          not null, primary key
#  from_city_id :integer
#  to_city_id   :integer
#  distance     :integer
#  created_at   :datetime
#  updated_at   :datetime
#  route_id     :integer
#  percentage   :integer
#

require 'spec_helper'

describe Connection do
  let(:connection) { build(:connection) }
  subject { connection }

  it { should be_valid }
  it { should belong_to(:from_city).class_name(:City) }
  it { should belong_to(:to_city).class_name(:City) }
  it { should belong_to(:routes).touch(true) }
  it { should validate_presence_of(:from_city) }
  it { should validate_presence_of(:to_city) }
  it { should validate_presence_of(:distance) }
end
