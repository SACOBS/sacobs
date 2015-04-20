
# == Schema Information
#
# Table name: connections
#
#  id         :integer          not null, primary key
#  distance   :integer
#  created_at :datetime
#  updated_at :datetime
#  route_id   :integer
#  percentage :decimal(5, 2)
#  cost       :decimal(8, 2)
#  name       :string(255)
#  from_id    :integer
#  to_id      :integer
#  arrive     :time
#  depart     :time
#
# Indexes
#
#  index_connections_on_from_id   (from_id)
#  index_connections_on_route_id  (route_id)
#  index_connections_on_to_id     (to_id)
#

class Connection < ActiveRecord::Base
  belongs_to :route, inverse_of: :connections
  belongs_to :from, -> { includes(:city) } ,class_name: :Destination, inverse_of: :connections
  belongs_to :to, -> { includes(:city) } ,class_name: :Destination, inverse_of: :connections

  validates :route, :from, :to, presence: true
  validates :cost, :percentage, presence: true, numericality: true

  before_save :set_percentage, if: :cost_changed?
  before_create :set_name

  delegate :city_id, :city_name, :city, to: :from, prefix: true, allow_nil: true
  delegate :city_id, :city_name, :city, to: :to, prefix: true,  allow_nil: true

  private

  def defaults
    {
      distance: 0,
      cost: 0,
      percentage: 0,
      arrive: Date.today.at_beginning_of_day,
      depart:  Date.today.noon
    }
  end

  protected

  def set_name
    self.name = "#{from.city_name} to #{to.city_name}"
  end

  def set_percentage
    self.percentage = ((cost / route.cost) * 100).round
  end
end
