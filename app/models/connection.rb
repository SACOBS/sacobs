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
#  cost         :integer
#

class Connection < ActiveRecord::Base
  belongs_to :route, touch: true
  belongs_to :from_city, class_name: :City
  belongs_to :to_city, class_name: :City

  attr_reader :description

  validates :route,:from_city, :to_city, :distance, presence: true

  before_save :calculate_route_percentage, :calculate_connection_cost

  delegate :name, to: :from_city, prefix: true
  delegate :name, to: :to_city, prefix: true

  validates :from_city, :to_city, :distance, :route, presence: true



  def description
    @description ||= "#{self.from_city_name} to #{self.to_city_name}"
  end

  protected
  def calculate_route_percentage
    self.percentage = (self.distance.to_f / self.route.distance.to_f) * 100
  end

  def calculate_connection_cost
    self.cost = ((self.percentage.to_f / 100) * self.route.cost).round(2)
  end

end
