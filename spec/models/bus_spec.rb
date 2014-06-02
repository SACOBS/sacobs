require 'spec_helper'

describe Bus do
  it { should belong_to(:user) }
  it { should have_many(:seats).dependent(:destroy) }

  it { should accept_nested_attributes_for(:seats).allow_destroy(true) }

  describe 'validations' do
    subject(:bus){ build_stubbed(:bus) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:capacity) }
    it { should validate_numericality_of(:capacity).is_greater_than(0) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:model) }
  end

end
