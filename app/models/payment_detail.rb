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

class PaymentDetail < ActiveRecord::Base
  belongs_to :payment_type
  belongs_to :booking
  belongs_to :user

  validates :payment_type, presence: true

  delegate :description, to: :payment_type, prefix: true

  private

  def defaults
    { payment_date: Time.zone.now }
  end
end
