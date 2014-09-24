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
#  index_discounts_on_user_id            (user_id)
#

class Discount < ActiveRecord::Base
  belongs_to :passenger_type
  belongs_to :user
  accepts_nested_attributes_for :passenger_type, reject_if: :all_blank, allow_destroy: true

  delegate :description, to: :passenger_type

  def percentage
    self[:percentage].to_f / 100
  end
end
