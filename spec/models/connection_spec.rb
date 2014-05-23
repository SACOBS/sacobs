# == Schema Information
#
# Table name: connections
#
#  id         :integer          not null, primary key
#  distance   :integer
#  created_at :datetime
#  updated_at :datetime
#  route_id   :integer
#  percentage :decimal(5, 2)
#  cost       :decimal(8, 2)
#  name       :string(255)
#  from_id    :integer
#  to_id      :integer
#  arrive     :time
#  depart     :time
#
# Indexes
#
#  index_connections_on_from_id   (from_id)
#  index_connections_on_route_id  (route_id)
#  index_connections_on_to_id     (to_id)
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
