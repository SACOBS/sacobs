# == Schema Information
#
# Table name: passenger_types
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'rails_helper'

describe PassengerType, :type => :model do
  it { is_expected.to validate_presence_of(:description) }

  describe 'callbacks' do
    it { is_expected.to callback(:format_description).before(:create) }

    describe '#format_description' do
      it 'downcases the description' do
        passenger_type = build_stubbed(:passenger_type, description: 'PenSIoner')
        passenger_type.send(:format_description)
        expect(passenger_type.description).to eq('pensioner')
      end
    end
  end
end
