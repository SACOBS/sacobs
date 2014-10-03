require 'rails_helper'

describe LocateStops do
  let(:east_london) {  create(:city, name: 'East London') }
  let(:port_alfred) { create(:city, name: 'Port Alfred') }
  let(:port_elizabeth) { create(:city, name: 'Port Elizabeth') }
  let(:summerstrand) { create(:city, name: 'Summerstrand') }

  let(:east_london_destination) { create(:destination, sequence: 1, city: east_london) }
  let(:port_alfred_destination) { create(:destination, sequence: 2, city: port_alfred) }
  let(:port_elizabeth_destination) { create(:destination, sequence: 3, city: port_elizabeth) }
  let(:summerstrand_destination) { create(:destination, sequence: 4, city: summerstrand) }

  let(:el_to_pa_connection) { create(:connection, from: east_london_destination, to: port_alfred_destination) }
  let(:el_to_pe_connection) { create(:connection, from: east_london_destination, to: port_elizabeth_destination) }
  let(:pa_to_pe_connection) { create(:connection, from: port_alfred_destination, to: port_elizabeth_destination) }
  let(:pe_to_summerstrand_connection) { create(:connection, from: port_elizabeth_destination, to: summerstrand_destination) }

  let(:el_to_summerstrand_route) { create(:route, connections: [el_to_pa_connection, el_to_pe_connection, pa_to_pe_connection, pe_to_summerstrand_connection], destinations: [east_london_destination, port_alfred_destination, port_elizabeth_destination, summerstrand_destination]) }

  let(:el_to_pa_stop) { create(:stop, connection: el_to_pa_connection) }
  let(:el_to_pe_stop) { create(:stop, connection: el_to_pe_connection) }
  let(:pa_to_pe_stop) { create(:stop, connection: pa_to_pe_connection) }
  let(:pe_to_summerstrand_stop) { create(:stop, connection: pe_to_summerstrand_connection) }

  let(:el_to_summerstrand_trip) { create(:trip, route: el_to_summerstrand_route, stops: [el_to_pa_stop, el_to_pe_stop, pa_to_pe_stop, pe_to_summerstrand_stop]) }

  it 'returns all the stops on a route from a city' do
    result = LocateStops.execute(el_to_summerstrand_trip, el_to_pe_stop)
    expect(result).to match_array [el_to_pa_stop, el_to_pe_stop, pa_to_pe_stop]
  end

  it 'excludes stops starting from the end city of the stop' do
    result = LocateStops.execute(el_to_summerstrand_trip, el_to_pe_stop)
    expect(result).to_not include(pe_to_summerstrand_stop)
  end
end
