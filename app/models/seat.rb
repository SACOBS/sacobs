# == Schema Information
#
# Table name: seats
#
#  id         :integer          not null, primary key
#  row        :string(255)      default("A-Z")
#  number     :integer          default(0)
#  bus_id     :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_seats_on_bus_id  (bus_id)
#

class Seat < ActiveRecord::Base
  belongs_to :bus, touch: true

  validates :row, presence: true
  validates :number, presence: true, numericality: true
end
