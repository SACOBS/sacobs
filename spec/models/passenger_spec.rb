require 'spec_helper'

describe Passenger do

  it { should belong_to(:booking) }
  it { should belong_to(:passenger_type) }

  describe 'instance methods' do
    describe '#full_name' do
      it 'returns the full name of the passenger' do
        passenger = build_stubbed(:passenger, name: 'Jim', surname: 'Jones')
        result = passenger.full_name
        expect(result).to eq('Jim Jones')
      end
    end
  end
end