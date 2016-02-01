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

class Charge < ActiveRecord::Base
  validates :description, :percentage, presence: true
  validates :description, uniqueness: { case_sensitive: false }

  before_save :normalize

  private

  def normalize
    self.description = description.to_s.squish.upcase
  end
end
