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
#

class PaymentDetail < ActiveRecord::Base
  PAYMENT_TYPES = [:Absa, :Nedbank, :StandardBank, :Capitec, :FNB, :POB, :Cash, :Cheque, :Investec].freeze

  belongs_to :booking

  validates :booking, :payment_type, presence: true

  before_create :set_payment_date

  private

  def set_payment_date
    self.payment_date = Time.current
  end
end
