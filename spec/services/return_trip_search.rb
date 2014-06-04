require 'rails_helper'

describe ReturnTripSearch do

 # Outgoing trip
  let(:east_london) {  create(:city, name: 'East London') }
  let(:port_alfred) { create(:city, name: 'Port Alfred') }
  let(:port_elizabeth) { create(:city, name: 'Port Elizabeth') }
  let(:summerstrand) { create(:city, name: 'Summerstrand')}

  let(:east_london_destination) { create(:destination, sequence: 1, city: east_london) }
  let(:port_alfred_destination) { create(:destination, sequence: 2, city: port_alfred) }
  let(:port_elizabeth_destination) { create(:destination, sequence: 3, city: port_elizabeth) }
  let(:summerstrand_destination) { create(:destination, sequence: 4, city: summerstrand)}

  let(:el_to_pa_connection){ create(:connection, from: east_london_destination, to: port_alfred_destination) }
  let(:el_to_pe_connection){ create(:connection, from: east_london_destination, to: port_elizabeth_destination) }
  let(:pa_to_pe_connection){ create(:connection, from: port_alfred_destination, to: port_elizabeth_destination)}
  let(:pe_to_summerstrand_connection){ create(:connection, from: port_elizabeth_destination, to: summerstrand_destination) }

  let(:el_to_summerstrand_route){ create(:route, connections: [el_to_pa_connection, el_to_pe_connection, pa_to_pe_connection,pe_to_summerstrand_connection  ], destinations: [east_london_destination, port_alfred_destination ,port_elizabeth_destination, summerstrand_destination ])}

  let(:el_to_pa_stop){ create(:stop, connection: el_to_pa_connection) }
  let(:el_to_pe_stop){ create(:stop, connection: el_to_pe_connection) }
  let(:pa_to_pe_stop){ create(:stop, connection: pa_to_pe_connection) }
  let(:pe_to_summerstrand_stop) { create(:stop, connection: pe_to_summerstrand_connection) }

  let(:el_to_summerstrand_trip){ create(:trip, route: el_to_summerstrand_route, stops: [el_to_pa_stop, el_to_pe_stop, pa_to_pe_stop, pe_to_summerstrand_stop], start_date: Date.today)}

  #Incoming trip
  let(:summerstrand_destination) { create(:destination, sequence: 1, city: summerstrand)}
  let(:port_elizabeth_destination) { create(:destination, sequence: 2, city: port_elizabeth) }
  let(:port_alfred_destination) { create(:destination, sequence: 3, city: port_alfred) }
  let(:east_london_destination) { create(:destination, sequence: 4, city: east_london) }

  let(:summerstrand_to_pe_connection){ create(:connection, to: port_elizabeth_destination, from: summerstrand_destination) }
  let(:summerstrand_to_pa_connection){ create(:connection, to: port_alfred_destination, from: summerstrand_destination) }
  let(:summerstrand_to_el_connection){ create(:connection, to: east_london_destination, from: summerstrand_destination) }
  let(:pe_to_pa_connection){ create(:connection, to: port_alfred_destination, from: port_elizabeth_destination)}
  let(:pe_to_el_connection){ create(:connection, to: east_london_destination, from: port_elizabeth_destination) }
  let(:pa_to_el_connection){ create(:connection, to: east_london_destination, from: port_alfred_destination) }

  let(:summerstrand_to_el_route){ create(:route, connections: [summerstrand_to_pe_connection, summerstrand_to_pa_connection, summerstrand_to_el_connection, pe_to_pa_connection, pe_to_el_connection, pa_to_el_connection  ], destinations: [east_london_destination, port_alfred_destination ,port_elizabeth_destination, summerstrand_destination ])}

  let(:summerstrand_to_pe_stop) { create(:stop, connection: summerstrand_to_pe_connection, available_seats: 1) }
  let(:summerstrand_to_pa_stop) { create(:stop, connection: summerstrand_to_pa_connection, available_seats: 1) }
  let(:summerstrand_to_el_stop) { create(:stop, connection: summerstrand_to_el_connection, available_seats: 1) }
  let(:pe_to_pa_stop){ create(:stop, connection: pe_to_pa_connection, available_seats: 1) }
  let(:pe_to_el_stop){ create(:stop, connection: pe_to_el_connection, available_seats: 1) }
  let(:pa_to_el_stop){ create(:stop, connection: pa_to_el_connection, available_seats: 1) }


  let(:summerstrand_to_el_trip){ create(:trip, route: summerstrand_to_el_route, stops: [summerstrand_to_pe_stop, summerstrand_to_pa_stop, summerstrand_to_el_stop, pe_to_pa_stop,pe_to_el_stop, pa_to_el_stop], start_date: Date.tomorrow)}


  describe 'return trips' do
    it 'searches for trips starting from the end city of the outgoing trip' do
      result = ReturnTripSearch.execute(el_to_summerstrand_trip, 1, criteria)
      expect(result).to match_array [summerstrand_to_pe_stop, summerstrand_to_pa_stop, summerstrand_to_el_stop, pe_to_pa_stop,pe_to_el_stop, pa_to_el_stop]
    end
  end

  describe 'seat quantity' do
    context 'valid' do
      it 'returns trips with seats available' do
        valid_quantity = 1
        result = ReturnTripSearch.execute(el_to_summerstrand_trip, valid_quantity , criteria)
        expect(result).to match_array [summerstrand_to_pe_stop, summerstrand_to_pa_stop, summerstrand_to_el_stop, pe_to_pa_stop,pe_to_el_stop, pa_to_el_stop]
      end
    end

    context 'invalid' do
      it 'returns no trips' do
        invalid_quantity = 100
        result = ReturnTripSearch.execute(el_to_summerstrand_trip, invalid_quantity, criteria)
        expect(result).to eq []
      end
    end
  end

  it 'searches all return trips on start date' do
    criteria = { trip_start_date_eq: Date.tomorrow }
    result = ReturnTripSearch.execute(el_to_summerstrand_trip, 1, criteria)
    expect(result).to match_array [summerstrand_to_pe_stop, summerstrand_to_pa_stop, summerstrand_to_el_stop, pe_to_pa_stop,pe_to_el_stop, pa_to_el_stop]
  end

  it 'searches all return trips on start city' do
    criteria = { connection_from_city_id_eq: port_elizabeth.id }
    result = ReturnTripSearch.execute(el_to_summerstrand_trip, 1, criteria)
    expect(result).to match_array [pe_to_pa_stop, pe_to_el_stop, pa_to_el_stop ]
  end

  it 'searches all return trips on end city' do
    criteria = { connection_to_city_id_eq: port_elizabeth.id }
    result = ReturnTripSearch.execute(el_to_summerstrand_trip, 1, criteria)
    expect(result).to match_array [summerstrand_to_pe_stop ]
  end

end