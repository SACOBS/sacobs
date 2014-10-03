# == Schema Information
#
# Table name: destinations
#
#  id         :integer          not null, primary key
#  route_id   :integer
#  city_id    :integer
#  sequence   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_destinations_on_city_id               (city_id)
#  index_destinations_on_city_id_and_route_id  (city_id,route_id)
#  index_destinations_on_route_id              (route_id)
#

require 'rails_helper'

describe Destination, type: :model do

  it { is_expected.to belong_to(:city) }
  it { is_expected.to belong_to(:route) }

  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:route) }
  it { is_expected.to validate_presence_of(:sequence) }
  it { is_expected.to delegate_method(:name).to(:city) }

end
