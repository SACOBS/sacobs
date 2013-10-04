# == Schema Information
#
# Table name: routes
#
#  id            :integer          not null, primary key
#  start_city_id :integer
#  end_city_id   :integer
#  cost          :decimal(, )
#  distance      :integer
#  created_at    :datetime
#  updated_at    :datetime
#

class Route < ActiveRecord::Base
  belongs_to :start_city, class_name: :City
  belongs_to :end_city, class_name: :City

  has_many :connections, dependent: :destroy

  validates :start_city, :end_city, :cost, :distance, presence: true

end
