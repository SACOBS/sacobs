require 'spec_helper'

describe Passenger, :type => :model do

  it { is_expected.to belong_to(:booking) }
  it { is_expected.to belong_to(:passenger_type) }

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