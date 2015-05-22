# == Schema Information
#
# Table name: charges
#
#  id          :integer          not null, primary key
#  percentage  :numeric(5,2)
#  user_id     :integer
#  created_at  :timestamp withou
#  updated_at  :timestamp withou
#  description :character varyin
#
# Indexes
#
#  index_charges_on_user_id  (user_id)
#

class Charge < ActiveRecord::Base
  belongs_to :user

  validates :description, :percentage, presence: true
end
