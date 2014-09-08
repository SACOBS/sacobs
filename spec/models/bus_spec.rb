# == Schema Information
#
# Table name: buses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  capacity   :integer
#  year       :string(255)
#  model      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#
# Indexes
#
#  index_buses_on_user_id  (user_id)
#

require 'rails_helper'

describe Bus, :type => :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:seats).dependent(:destroy) }

  it { is_expected.to accept_nested_attributes_for(:seats).allow_destroy(true) }

  describe 'validations' do
    subject(:bus){ build_stubbed(:bus) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:capacity) }
    it { is_expected.to validate_numericality_of(:capacity).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:year) }
    it { is_expected.to validate_presence_of(:model) }
  end

end
