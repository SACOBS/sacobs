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
  has_many :seats, dependent: :delete_all

  accepts_nested_attributes_for :seats, reject_if: :all_blank, allow_destroy: true

  with_options on: :update do |model|
    model.validates :name, :capacity, :year, :model, presence: true
    model.validates :capacity, numericality: { greater_than: 0 }
  end

  def build_seats
    seats.clear
    capacity.times { seats.build }
  end

  private

  def defaults
    { name: 'Bus', capacity: 0, year: 1, model: 'bus' }
  end
end
