# == Schema Information
#
# Table name: seats
#
#  id         :integer          not null, primary key
#  row        :character varyin
#  number     :integer
#  bus_id     :integer
#  created_at :timestamp withou
#  updated_at :timestamp withou
#
# Indexes
#
#  index_seats_on_bus_id  (bus_id)
#

class Seat < ActiveRecord::Base
  belongs_to :bus, touch: true

  validates :row, :number, presence: true
  validates :number, numericality: true

  after_initialize :set_defaults, if: :new_record?

  private

  def set_defaults
    self.row ||= 'A-Z'
    self.number ||= 0
  end
end
