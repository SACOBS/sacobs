# == Schema Information
#
# Table name: line_items
#
#  id                  :integer          not null, primary key
#  description         :string(255)
#  amount              :decimal(, )
#  discount_percentage :integer
#  discount_amount     :decimal(, )
#  invoice_id          :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class LineItem < ActiveRecord::Base
  belongs_to :invoice, touch: true
end
