# == Schema Information
#
# Table name: payment_details
#
#  id           :integer          not null, primary key
#  payment_date :datetime
#  booking_id   :integer
#  reference    :string(255)
#  user_id      :integer
#  payment_type :string(255)
#
# Indexes
#
#  index_payment_details_on_booking_id  (booking_id)
#  index_payment_details_on_user_id     (user_id)
#

class PaymentDetail < ActiveRecord::Base
  PAYMENT_TYPES = [:Absa, :Nedbank, :StandardBank, :Nedbank, :Capitec, :FNB, :POB, :Cash, :Cheque, :Investec].freeze

  belongs_to :booking

  validates :booking, :payment_type, presence: true

  private

  def defaults
    { payment_date: Time.zone.now }
  end
end
