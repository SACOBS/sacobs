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

class Charge < ActiveRecord::Base

  validates :description, :percentage, presence: true

  before_save do
    self.description = description.upcase
  end
end
