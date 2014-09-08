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

require 'rails_helper'

describe Charge, :type => :model do
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:percentage) }
end
