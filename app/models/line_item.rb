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
#  line_item_type :string(255)
#
# Indexes
#
#  index_line_items_on_invoice_id  (invoice_id)
#

class LineItem < ActiveRecord::Base
  include AttributeDefaults

  enum :line_item_type, [:debit, :credit]

  belongs_to :invoice

  scope :total_debits, -> { where(line_item_type: :debit).sum(:amount) }
  scope :total_credits, -> { where(line_item_type: :credit).sum(:amount) }


  private
    def defaults
     {
        amount: 0
     }
    end
end
