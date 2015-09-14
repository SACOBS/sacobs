# == Schema Information
#
# Table name: discounts
#
#  id                :integer          not null, primary key
#  percentage        :decimal(5, 2)
#  passenger_type_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#
# Indexes
#
#  index_discounts_on_passenger_type_id  (passenger_type_id)
#

class Discount < ActiveRecord::Base
  belongs_to :passenger_type, required: true
  accepts_nested_attributes_for :passenger_type

  validates :percentage, presence: true

  def description
    "#{passenger_type.description}".capitalize
  end
end
