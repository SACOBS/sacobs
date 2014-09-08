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

require 'rails_helper'

describe Connection, :type => :model do

  it { is_expected.to belong_to(:route).touch(true).counter_cache(true) }
  it { is_expected.to belong_to(:from).class_name(:Destination) }
  it { is_expected.to belong_to(:to).class_name(:Destination) }

  it { is_expected.to validate_presence_of(:route) }
  it { is_expected.to validate_presence_of(:from) }
  it { is_expected.to validate_presence_of(:to) }
  it { is_expected.to validate_presence_of(:cost) }
  it { is_expected.to validate_presence_of(:percentage) }
  it { is_expected.to validate_numericality_of(:cost) }
  it { is_expected.to validate_numericality_of(:percentage) }


  describe 'callbacks' do
    it { is_expected.to callback(:set_name).before(:save) }
    it { is_expected.to callback(:set_percentage).before(:create) }

    describe '#set_name' do
      it 'sets the connection name' do
        connection = build_stubbed(:connection)
        expected = "#{connection.from.name} to #{connection.to.name}"
        connection.send(:set_name)
        expect(connection.name).to eq(expected)
      end
    end

    describe '#set_percentage' do
      it 'sets the percentage' do
        connection = build_stubbed(:connection)
        expected = ((connection.cost / connection.route.cost) * 100).round
        connection.send(:set_percentage)
        expect(connection.percentage).to eq(expected)
      end
    end
  end



end
