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
  include AttributesEmpty

  belongs_to :start_city, class_name: :City
  belongs_to :end_city, class_name: :City

  has_many :connections, dependent: :destroy

  accepts_nested_attributes_for :connections,  reject_if: :all_blank, allow_destroy: true

  validates :start_city, :end_city, :cost, :distance, presence: true

  delegate :name, to: :start_city, prefix: true, allow_nil: true
  delegate :name, to: :end_city, prefix: true, allow_nil: true

  def to_s
    "#{start_city_name} to #{end_city_name}"
  end

end
