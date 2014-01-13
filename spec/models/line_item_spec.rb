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
# Indexes
#
#  index_line_items_on_invoice_id  (invoice_id)
#

require 'spec_helper'

describe LineItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
