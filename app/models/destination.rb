# == Schema Information
#
# Table name: destinations
#
#  id                :integer          not null, primary key
#  route_id          :integer
#  city_id           :integer
#  destination_order :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Destination < ActiveRecord::Base
  belongs_to :city
  belongs_to :route

  scope :preceding, ->(sequence) { where("destination_order < ?", sequence )  }

  validates :destination_order, :route, :city, presence: true

  delegate :name, to: :city
end
