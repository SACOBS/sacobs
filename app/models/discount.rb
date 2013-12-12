# == Schema Information
#
# Table name: discounts
#
#  id                :integer          not null, primary key
#  percentage        :decimal(2, 5)
#  passenger_type_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#

class Discount < ActiveRecord::Base
  belongs_to :passenger_type
  belongs_to :user
  accepts_nested_attributes_for :passenger_type, reject_if: :all_blank, allow_destroy: true
end
