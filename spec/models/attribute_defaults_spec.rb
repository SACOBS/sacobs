require 'spec_helper'

describe AttributeDefaults do

  it 'should call the set default attributes method' do
    city = City.allocate
    city.should_receive(:set_default_attributes)
    city.send(:initialize)
  end

  it 'sets the values according to the defaults supplied' do
    default_values = {name: 'Test'}
    City.any_instance.stub(:defaults).and_return(default_values)
    city = City.new
    city.name.should eql('Test')
  end

  it "doesn't overwrite the values if they are not nil" do
    default_values = {name: 'Test'}
    City.any_instance.stub(:defaults).and_return(default_values)
    city = City.new(name: 'Bob')
    city.name.should_not eql('Test')
  end
end
