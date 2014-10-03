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

require 'rails_helper'

describe Discount, type: :model do
  it { is_expected.to belong_to(:passenger_type) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to accept_nested_attributes_for(:passenger_type).allow_destroy(true) }

end
