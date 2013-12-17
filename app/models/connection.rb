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
#  percentage   :decimal(2, 5)
#  cost         :decimal(8, 2)
#  name         :string(255)
#

class Connection < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :route, counter_cache: true
  belongs_to :from_city, class_name: :City
  belongs_to :to_city, class_name: :City

  validates :route,:from_city, :to_city, presence: true

  before_save :set_name

  delegate :name, to: :from_city, prefix: true
  delegate :name, to: :to_city, prefix: true

  private
   def defaults
     { distance: 0, cost: 0, percentage: 0 }
   end

  protected
    def set_name
      self.name = "#{self.from_city_name} to #{self.to_city_name}"
    end

end
