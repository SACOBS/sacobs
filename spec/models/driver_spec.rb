require 'spec_helper'

describe Driver, :type => :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_and_belong_to_many(:trips) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:surname) }

  describe 'instance methods' do
    describe '#full_name' do
      it 'should concatenate the driver name and surname' do
        driver = build_stubbed(:driver, name: 'Jim', surname: 'James')
        expect(driver.full_name).to eq('Jim James')
      end
    end
  end



end