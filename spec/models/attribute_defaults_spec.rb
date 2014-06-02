require 'spec_helper'

describe AttributeDefaults, :type => :model do

  it 'should call the set default attributes method' do
    city = City.allocate
    expect(city).to receive(:set_default_attributes)
    city.send(:initialize)
  end

  it 'sets the values according to the defaults supplied' do
    default_values = {name: 'Test'}
    allow_any_instance_of(City).to receive(:defaults).and_return(default_values)
    city = City.new
    expect(city.name).to eql('Test')
  end

  it "doesn't overwrite the values if they are not nil" do
    default_values = {name: 'Test'}
    allow_any_instance_of(City).to receive(:defaults).and_return(default_values)
    city = City.new(name: 'Bob')
    expect(city.name).not_to eql('Test')
  end
end
