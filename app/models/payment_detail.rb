# == Schema Information
#
# Table name: payment_details
#
#  id           :integer          not null, primary key
#  payment_date :datetime
#  bank_id      :integer
#  booking_id   :integer
#  reference    :string(255)
#  user_id      :integer
#
# Indexes
#
#  index_payment_details_on_bank_id     (bank_id)
#  index_payment_details_on_booking_id  (booking_id)
#  index_payment_details_on_user_id     (user_id)
#

class PaymentDetail < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :bank
  belongs_to :booking, touch: true
  belongs_to :user

  validates :bank, presence: true

  delegate :name, to: :bank, prefix: true

  private
   def defaults
     { payment_date: Time.zone.now }
   end
end
