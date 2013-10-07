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

  accepts_nested_attributes_for :connections,  reject_if: :all_blank, allow_destroy: true

  validates :start_city, :end_city, :cost, :distance, presence: true

end
