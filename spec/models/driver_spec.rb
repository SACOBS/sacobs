require 'spec_helper'

describe Driver do
  it { should belong_to(:user) }
  it { should have_and_belong_to_many(:trips) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surname) }

  describe 'instance methods' do
    describe '#full_name' do
      it 'should concatenate the driver name and surname' do
        driver = build_stubbed(:driver, name: 'Jim', surname: 'James')
        expect(driver.full_name).to eq('Jim James')
      end
    end
  end



end