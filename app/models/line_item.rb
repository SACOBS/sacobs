# == Schema Information
#
# Table name: line_items
#
#  id                  :integer          not null, primary key
#  description         :string(255)
#  discount_percentage :integer
#  discount_amount     :decimal(8, 2)
#  invoice_id          :integer
#  created_at          :datetime
#  updated_at          :datetime
#  gross_price         :decimal(8, 2)
#  nett_price          :decimal(8, 2)
#

class LineItem < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :invoice

  private
    def defaults
     {
        discount_percentage: 0,
        discount_amount: 0,
        gross_price: 0,
        nett_price: 0
     }
    end
end
