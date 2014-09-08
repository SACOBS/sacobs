# == Schema Information
#
# Table name: payment_details
#
#  id              :integer          not null, primary key
#  payment_date    :datetime
#  booking_id      :integer
#  reference       :string(255)
#  user_id         :integer
#  payment_type_id :integer
#
# Indexes
#
#  index_payment_details_on_booking_id       (booking_id)
#  index_payment_details_on_payment_type_id  (payment_type_id)
#  index_payment_details_on_user_id          (user_id)
#

require 'rails_helper'

describe PaymentDetail, :type => :model do
  it { is_expected.to belong_to(:payment_type) }
  it { is_expected.to belong_to(:booking).touch(true) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:payment_type) }

  it { is_expected.to delegate_method(:payment_type_description).to(:payment_type).as(:description) }

end
