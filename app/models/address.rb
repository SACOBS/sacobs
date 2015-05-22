# == Schema Information
#
# Table name: addresses
#
#  id               :integer          not null, primary key
#  street_address1  :character varyin
#  street_address2  :character varyin
#  city             :character varyin
#  postal_code      :character varyin
#  addressable_id   :integer
#  addressable_type :character varyin
#  created_at       :timestamp withou
#  updated_at       :timestamp withou
#
# Indexes
#
#  index_addresses_on_addressable_id_and_addressable_type  (addressable_id,addressable_type)
#

class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
end
