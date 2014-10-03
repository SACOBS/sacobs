# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  street_address1  :string(255)
#  street_address2  :string(255)
#  city             :string(255)
#  postal_code      :string(255)
#  addressable_id   :integer
#  addressable_type :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_addresses_on_addressable_id_and_addressable_type  (addressable_id,addressable_type)
#

require 'rails_helper'

describe Address, type: :model do

  it { is_expected.to belong_to(:addressable) }

  it { is_expected.to validate_presence_of(:street_address1) }
  it { is_expected.to validate_presence_of(:street_address2) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:postal_code) }
end
