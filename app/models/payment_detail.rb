# == Schema Information
#
# Table name: payment_details
#
#  id           :integer          not null, primary key
#  paid_at      :datetime
#  reference    :string(255)
#  user_id      :integer
#  payment_type :string(255)
#

class PaymentDetail < ActiveRecord::Base
  PAYMENT_TYPES = %i(Absa Nedbank StandardBank Capitec FNB POB Cash Cheque Investec).freeze

  has_many :bookings

  validates :payment_type, :reference, presence: true
  validates :reference, uniqueness: true

  before_create :set_paid_at

  private

  def set_paid_at
    self.paid_at ||= Time.current
  end
end
