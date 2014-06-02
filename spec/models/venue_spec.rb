require 'spec_helper'

describe Venue do
  it { should belong_to(:city).counter_cache(true).touch(true) }
  it { should validate_presence_of(:name) }
end