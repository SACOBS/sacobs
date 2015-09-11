# == Schema Information
#
# Table name: routes
#
#  id         :integer          not null, primary key
#  cost       :decimal(8, 2)
#  distance   :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  user_id    :integer
#

class Route < ActiveRecord::Base
  to_param :name

  has_many :destinations

  has_many :connections

  accepts_nested_attributes_for :connections, reject_if: :all_blank
  accepts_nested_attributes_for :destinations, reject_if: :all_blank, allow_destroy: true

  validates :name, :cost, :distance, presence: true
  validates :cost, :distance, numericality: true
  validates :destinations, presence: true, length: { minimum: 2, too_short: 'is too short (at least %{count} destinations required)' }

  before_save :normalize

  private

  def normalize
    self.name = name.squish.upcase
  end
end
