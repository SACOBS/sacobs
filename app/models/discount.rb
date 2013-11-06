# == Schema Information
#
# Table name: discounts
#
#  id                :integer          not null, primary key
#  percentage        :integer
#  passenger_type_id :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class Discount < ActiveRecord::Base
  belongs_to :passenger_type
end
