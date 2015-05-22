# == Schema Information
#
# Table name: payment_details
#
#  id           :integer          not null, primary key
#  payment_date :timestamp withou
#  booking_id   :integer
#  reference    :character varyin
#  user_id      :integer
#  payment_type :character varyin
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

  before_create :set_payment_date

  private

  def set_payment_date
    self.payment_date = Time.current
  end
end
