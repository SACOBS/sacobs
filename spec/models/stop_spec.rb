require 'spec_helper'

describe Stop do
 it { should belong_to(:trip).touch(true) }
 it { should belong_to(:connection) }
 it { should have_many(:bookings) }

 it { should delegate_method(:name).to(:connection) }
 it { should delegate_method(:from).to(:connection) }
 it { should delegate_method(:to).to(:connection) }
 it { should delegate_method(:cost).to(:connection) }


 describe 'callbacks' do
   it { should callback(:check_seats).before(:save) }

   describe '#check_seats' do
     it 'sets the seats to zero if a negative number' do
       stop = build_stubbed(:stop, available_seats: -2)
       stop.send(:check_seats)
       expect(stop.available_seats).to be_zero
     end
   end
 end

 describe 'class methods' do
   describe '.en_route' do
     it 'returns all stops en route from destination provided' do
       route = create(:route)
       trip = create(:trip, route: route)
       destination = create(:destination, sequence: 1)
       connection = create(:connection, to: destination, route: route)
       destination2 = create(:destination, sequence: 2)
       connection2 = create(:connection, to: destination2, route: route)
       stop = create(:stop, connection: connection, trip: trip)
       stop2 = create(:stop, connection: connection2, trip: trip)

       result = Stop.en_route(destination)
       expect(result).to eq [stop2]
     end
   end

   describe '.valid' do
     it 'returns stops for valid trips' do
       trip = create(:trip, start_date: Date.today)
       stop = create(:stop, trip: trip)
       result = Stop.valid
       expect(result).to eq [stop]
     end
   end
 end

end