# == Schema Information
#
# Table name: routes
#
#  id                :integer          not null, primary key
#  cost              :decimal(8, 2)
#  distance          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  name              :string(255)
#  slug              :string(255)
#  user_id           :integer
#  connections_count :integer          default(0)
#
# Indexes
#
#  index_routes_on_slug  (slug) UNIQUE
#

require 'spec_helper'

describe Route do
  let(:routes) { build(:routes) }
  subject { route }

  it { should be_valid }
  it { should belong_to(:start_city).class_name(:City) }
  it { should belong_to(:end_city).class_name(:City) }
  it { should have_many(:connections).dependent(:destroy) }
  it { should validate_presence_of(:start_city) }
  it { should validate_presence_of(:end_city) }
  it { should validate_presence_of(:cost) }
  it { should validate_presence_of(:distance) }

end
