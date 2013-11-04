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

require 'spec_helper'

describe LineItem do
  pending "add some examples to (or delete) #{__FILE__}"
end
