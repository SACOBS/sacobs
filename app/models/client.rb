# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Client < ActiveRecord::Base
  has_one :address, as: :addressable
  has_many :bookings, dependent: :destroy

  accepts_nested_attributes_for :address

  delegate :street_address1, :street_address2, :city, :postal_code, to: :address, prefix: false

  def to_s
    "#{self.name} #{self.surname}".titleize
  end
end
