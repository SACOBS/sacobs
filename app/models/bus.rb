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

class Bus < ActiveRecord::Base
  include AttributesEmpty

  belongs_to :user
  has_many :seats, dependent: :destroy

  accepts_nested_attributes_for :seats, reject_if: :all_blank, allow_destroy: true

  validates :name, :capacity, :year, :model, presence: true, on: :update

  before_update :build_seats

  protected
  def build_seats
    (self.capacity - self.seats.count).times { self.seats.build }
  end
end
