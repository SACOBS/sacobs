# == Schema Information
#
# Table name: discounts
#
#  id                :integer          not null, primary key
#  percentage        :numeric(5,2)
#  passenger_type_id :integer
#  created_at        :timestamp withou
#  updated_at        :timestamp withou
#  user_id           :integer
#
# Indexes
#
#  index_discounts_on_passenger_type_id  (passenger_type_id)
#  index_discounts_on_user_id            (user_id)
#

class Discount < ActiveRecord::Base
  belongs_to :passenger_type, dependent: :destroy
  accepts_nested_attributes_for :passenger_type

  validates :passenger_type, :percentage, presence: true

  delegate :description, to: :passenger_type

end
