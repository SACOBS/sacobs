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
