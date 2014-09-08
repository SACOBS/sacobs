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

  belongs_to :booking
  has_many :line_items, dependent: :delete_all

  accepts_nested_attributes_for :line_items, reject_if: :all_blank

  def total
    total_cost - total_discount
  end

  def total_cost
    line_items.debit.sum(:amount)
  end

  def total_discount
    line_items.credit.sum(:amount)
  end


  private
  def defaults
    { billing_date: Time.zone.now }
  end

end
