# == Schema Information
#
# Table name: line_items
#
#  id             :integer          not null, primary key
#  description    :string(255)
#  invoice_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#  amount         :decimal(8, 2)
#  line_item_type :integer
#
# Indexes
#
#  index_line_items_on_invoice_id  (invoice_id)
#

require 'rails_helper'

describe LineItem, type: :model do
  it { is_expected.to belong_to(:invoice) }
end
