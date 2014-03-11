# == Schema Information
#
# Table name: charges
#
#  id          :integer          not null, primary key
#  percentage  :decimal(5, 2)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :string(255)
#

class Charge < ActiveRecord::Base
  belongs_to :passenger_type
  belongs_to :user
  accepts_nested_attributes_for :passenger_type, reject_if: :all_blank, allow_destroy: true
end
