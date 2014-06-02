require 'spec_helper'

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