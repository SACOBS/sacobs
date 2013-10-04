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
#

class Connection < ActiveRecord::Base
  belongs_to :route, touch: true
  belongs_to :from_city, class_name: :City
  belongs_to :to_city, class_name: :City

  validates :route,:from_city, :to_city, :distance, presence: true

end
