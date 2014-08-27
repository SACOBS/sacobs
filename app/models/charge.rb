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
  belongs_to :user

  validates :description, :percentage, presence: true

  def percentage
    self[:percentage].to_f / 100
  end


end
