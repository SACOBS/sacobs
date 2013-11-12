# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  tel_no     :string(255)
#  cell_no    :string(255)
#  email      :string(255)
#  slug       :string(255)
#  user_id    :integer
#

class Client < ActiveRecord::Base
  extend FriendlyId


  has_one :address, as: :addressable
  has_many :bookings, dependent: :destroy

  accepts_nested_attributes_for :address, reject_if: :all_blank, allow_destroy: true

  delegate :street_address1, :street_address2, :city, :postal_code, to: :address, prefix: false, allow_nil: true

  friendly_id :full_name, use: :slugged

  def full_name
    "#{self.name} #{self.surname}"
  end

end
