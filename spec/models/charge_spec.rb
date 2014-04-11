# == Schema Information
#
# Table name: charges
#
#  id          :integer          not null, primary key
#  percentage  :decimal(5, 2)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#  description :string(255)
#
# Indexes
#
#  index_charges_on_user_id  (user_id)
#

require 'spec_helper'

describe Charge do
  pending "add some examples to (or delete) #{__FILE__}"
end
