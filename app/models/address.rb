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

class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true

  validates :street_address1, :street_address2, :city, :postal_code, presence: true
end
