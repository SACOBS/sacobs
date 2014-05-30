require 'spec_helper'

describe Connection do

  it { should belong_to(:route).touch(true).counter_cache(true) }
  it { should belong_to(:from).class_name(:Destination) }
  it { should belong_to(:to).class_name(:Destination) }

  it { should validate_presence_of(:route) }
  it { should validate_presence_of(:from) }
  it { should validate_presence_of(:to) }
  it { should validate_presence_of(:cost) }
  it { should validate_presence_of(:percentage) }
  it { should validate_numericality_of(:cost) }
  it { should validate_numericality_of(:percentage) }


  describe 'callbacks' do
    it { should callback(:set_name).before(:save) }
    it { should callback(:set_percentage).before(:create) }

    describe '#set_name' do
      it 'sets the connection name' do
        connection = build(:connection)
        expected = "#{connection.from.name} to #{connection.to.name}"
        connection.send(:set_name)
        expect(connection.name).to eq(expected)
      end
    end

    describe '#set_percentage' do
      it 'sets the percentage' do
        connection = build(:connection)
        expected = ((connection.cost / connection.route.cost) * 100).round
        connection.send(:set_percentage)
        expect(connection.percentage).to eq(expected)
      end
    end
  end



end