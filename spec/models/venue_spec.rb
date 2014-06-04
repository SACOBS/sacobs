require 'rails_helper'

describe Venue, :type => :model do
  it { is_expected.to belong_to(:city).counter_cache(true).touch(true) }
  it { is_expected.to validate_presence_of(:name) }
end