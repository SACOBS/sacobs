# == Schema Information
#
# Table name: payment_details
#
#  id           :integer          not null, primary key
#  paid_at      :datetime         default(Fri, 04 Sep 2015 11:18:07 SAST +02:00)
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

  validates :booking, :payment_type, :reference, presence: true
  validates :reference, uniqueness: true

  before_create :set_paid_at

  private

  def set_paid_at
    self.paid_at ||= Time.current
  end
end
