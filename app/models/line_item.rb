# == Schema Information
#
# Table name: line_items
#
#  id             :integer          not null, primary key
#  description    :string(255)
#  invoice_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#  amount         :decimal(8, 2)    default(0.0)
#  line_item_type :integer
#
# Indexes
#
#  index_line_items_on_invoice_id  (invoice_id)
#

class LineItem < ActiveRecord::Base
  default_scope { order(:id) }

  enum line_item_type: [:debit, :credit]

  belongs_to :invoice

end
