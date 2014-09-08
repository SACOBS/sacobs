# == Schema Information
#
# Table name: drivers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#  user_id    :integer
#
# Indexes
#
#  index_drivers_on_slug     (slug) UNIQUE
#  index_drivers_on_user_id  (user_id)
#

require 'rails_helper'

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
