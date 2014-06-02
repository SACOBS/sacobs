require 'spec_helper'

describe Route, :type => :model do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:destinations).order(:sequence).dependent(:destroy) }
  it { is_expected.to have_many(:connections).order(:from_id).dependent(:destroy) }

  it { is_expected.to accept_nested_attributes_for(:connections).allow_destroy(true) }
  it { is_expected.to accept_nested_attributes_for(:destinations).allow_destroy(true) }


  describe 'validations' do
    subject(:route) { create(:route) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:cost) }
    it { is_expected.to validate_presence_of(:distance) }
  end


  describe 'callbacks' do
    it { is_expected.to callback(:set_connection_costs).before(:save).if(:cost_changed?) }

    describe '#set_connection_costs?' do
      it 'updates the cost of a connection' do
        connection = build_stubbed(:connection, cost: 0, percentage: 10)
        route = build_stubbed(:route, cost: 100, connections: [connection])
        route.send(:set_connection_costs)
        expect(route.connections.first.cost).to eq(10.00)
      end
    end
  end

  describe 'instance methods' do
    let(:start_destination) { build_stubbed(:destination, sequence: 1) }
    let(:end_destination) { build_stubbed(:destination, sequence: 2) }
    let(:route) { build_stubbed(:route, destinations: [start_destination, end_destination])}

    describe '#start_city' do
      it 'returns the start city' do
        expect(route.start_city).to eq(start_destination.city)
      end
    end

    describe '#end_city' do
      it 'returns the end city' do
        expect(route.end_city).to eq(end_destination.city)
      end
    end
  end

end