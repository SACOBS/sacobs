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
#

class Connection < ActiveRecord::Base
  belongs_to :route, touch: true
  belongs_to :from_city, class_name: :City
  belongs_to :to_city, class_name: :City

  validates :route,:from_city, :to_city, :distance, presence: true

  before_save :calculate_route_percentage, :calculate_connection_cost


  protected
  def calculate_route_percentage
    self.percentage = (self.distance.to_f / self.route.distance.to_f) * 100
  end

  def calculate_connection_cost
    self.cost = (self.percentage.to_f / 100) * self.route.cost
  end

end
