# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  city_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_venues_on_city_id  (city_id)
#

require 'rails_helper'

describe Venue, :type => :model do
  it { is_expected.to belong_to(:city).counter_cache(true).touch(true) }
  it { is_expected.to validate_presence_of(:name) }
end
