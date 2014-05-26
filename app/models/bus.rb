# == Schema Information
#
# Table name: buses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  capacity   :integer
#  year       :string(255)
#  model      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#
# Indexes
#
#  index_buses_on_user_id  (user_id)
#

class Bus < ActiveRecord::Base

  belongs_to :user
  has_many :seats, dependent: :destroy

  accepts_nested_attributes_for :seats, reject_if: :all_blank, allow_destroy: true

  validates :name, :capacity, :year, :model, presence: true, on: :update
  validates :capacity, numericality: { greater_than: 0 }, on: :update
  #validate :seating_matches_capacity, on: :update


  private
   def defaults
     { name: 'Bus', capacity: 0, year: 1, model: 'bus'}
   end

   def seating_matches_capacity
    self.errors.add(:base,"The number of seats (#{self.seats.size}) does not match the capacity of the bus (#{self.capacity}).") unless self.capacity == self.seats.size
  end
end
