# == Schema Information
#
# Table name: line_items
#
#  id                  :integer          not null, primary key
#  description         :string(255)
#  amount              :decimal(8, 2)
#  discount_percentage :integer
#  discount_amount     :decimal(8, 2)
#  invoice_id          :integer
#  created_at          :datetime
#  updated_at          :datetime
#  gross_price         :decimal(8, 2)
#  nett_price          :decimal(8, 2)
#

class LineItem < ActiveRecord::Base
  belongs_to :invoice, touch: true
end
