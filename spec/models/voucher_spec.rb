# == Schema Information
#
# Table name: vouchers
#
#  id         :integer          not null, primary key
#  ref_no     :string(255)
#  amount     :decimal(, )
#  active     :boolean          default(TRUE)
#  client_id  :integer
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#
# Indexes
#
#  index_vouchers_on_client_id  (client_id)
#  index_vouchers_on_user_id    (user_id)
#

require 'spec_helper'

describe Voucher do
  pending "add some examples to (or delete) #{__FILE__}"
end
