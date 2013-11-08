# == Schema Information
#
# Table name: connections
#
#  id           :integer          not null, primary key
#  from_city_id :integer
#  to_city_id   :integer
#  distance     :integer
#  created_at   :datetime
#  updated_at   :datetime
#  route_id     :integer
#  percentage   :integer
#  cost         :decimal(8, 2)
#  name         :string(255)
#

class Connection < ActiveRecord::Base
  belongs_to :route, touch: true
  belongs_to :from_city, class_name: :City
  belongs_to :to_city, class_name: :City


  validates :route,:from_city, :to_city, :distance, presence: true

  before_save :calculate_connection_cost, :set_name

  delegate :name, to: :from_city, prefix: true
  delegate :name, to: :to_city, prefix: true

  validates :from_city, :to_city, :distance, :route, presence: true

  protected
  def calculate_connection_cost
    self.cost = ((BigDecimal(self.percentage) / 100) * self.route.cost)
  end

  def set_name
    self.name = "#{self.from_city_name} to #{self.to_city_name}"
  end

end
