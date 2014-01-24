# == Schema Information
#
# Table name: invoices
#
#  id           :integer          not null, primary key
#  booking_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#  billing_date :datetime
#
# Indexes
#
#  index_invoices_on_booking_id  (booking_id)
#

class Invoice < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :booking
  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :line_items, reject_if: :all_blank

  def total
   self.line_items.total_debits.round(2) - self.line_items.total_credits.round(2)
  end

  def total_discount
   self.line_items.total_credits.round(2)
  end


  private
  def defaults
    { billing_date: Time.zone.now }
  end

end
