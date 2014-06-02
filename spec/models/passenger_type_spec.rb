require 'spec_helper'

describe PassengerType do
  it { should validate_presence_of(:description) }

  describe 'callbacks' do
    it { should callback(:format_description).before(:create) }

    describe '#format_description' do
      it 'downcases the description' do
        passenger_type = build_stubbed(:passenger_type, description: 'PenSIoner')
        passenger_type.send(:format_description)
        expect(passenger_type.description).to eq('pensioner')
      end
    end
  end
end