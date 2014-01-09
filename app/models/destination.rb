# == Schema Information
#
# Table name: destinations
#
#  id                :integer          not null, primary key
#  route_id          :integer
#  city_id           :integer
#  sequence :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Destination < ActiveRecord::Base
  belongs_to :city
  belongs_to :route

  validates :sequence, :route, :city, presence: true

  delegate :name, to: :city
end
