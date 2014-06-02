require 'spec_helper'

describe Trip, :type => :model do

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:bus) }
  it { is_expected.to belong_to(:route) }
  it { is_expected.to have_many(:stops).dependent(:destroy) }
  it { is_expected.to have_many(:bookings).dependent(:destroy) }
  it { is_expected.to have_and_belong_to_many(:drivers) }

  it { is_expected.to accept_nested_attributes_for(:stops).allow_destroy(true) }

  it { is_expected.to delegate_method(:bus_name).to(:bus).as(:name) }
  it { is_expected.to delegate_method(:bus_capacity).to(:bus).as(:capacity) }

  describe 'validations' do
    subject(:trip) { build_stubbed(:trip) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:start_date) }
    it { is_expected.to validate_presence_of(:end_date) }
    it { is_expected.to validate_presence_of(:route) }
    it { is_expected.to validate_presence_of(:bus) }


  end

  describe 'callbacks' do
    it { is_expected.to callback(:generate_stops).before(:update) }

    describe '#generate_stops' do
      it 'creates the stops for the trip from the route connections' do
        route = build_stubbed(:route, connections: [build_stubbed(:connection)])
        trip = build_stubbed(:trip, route: route)
        trip.send(:generate_stops)
        expect(trip.stops).to_not be nil
      end
    end
  end

  describe 'class methods' do
    describe '.valid' do
      it 'returns active trips' do
          valid_trip = create(:trip, start_date: Date.tomorrow)
          invalid_trip = create(:trip, start_date: Date.yesterday)
          result = Trip.valid
          expect(result).to eq [valid_trip]
      end
    end

    describe '.archived' do
      it 'returns archived trips' do
        archived_trip = create(:trip, start_date: Date.yesterday)
        not_archived_trip = create(:trip, start_date: Date.tomorrow)
        result = Trip.archived
        expect(result).to eq [archived_trip]
      end
    end

    describe '.from_location' do
      it 'finds all trips leaving from the specified location' do
        city = create(:city)
        destination = create(:destination, sequence: 1, city: city)
        connection = create(:connection, from: destination)
        route = create(:route, connections: [connection], destinations: [destination])
        trip = create(:trip, route: route)
        result = Trip.from_location(city)
        expect(result).to eq [trip]
      end
    end
  end

end