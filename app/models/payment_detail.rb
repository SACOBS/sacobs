# == Schema Information
#
# Table name: payment_details
#
#  id           :integer          not null, primary key
#  payment_date :datetime
#  bank_id      :integer
#  booking_id   :integer
#  reference    :string(255)
#

class PaymentDetail < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :bank
  belongs_to :booking

  validates :bank, presence: true

  delegate :name, to: :bank, prefix: true

  private
   def defaults
     { payment_date: Time.zone.now }
   end
end
