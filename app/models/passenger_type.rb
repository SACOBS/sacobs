# == Schema Information
#
# Table name: passenger_types
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class PassengerType < ActiveRecord::Base
  default_scope { order(:description) }

  validates :description, presence: true
  validates :description, uniqueness: { case_sensitive: false }

  before_save :normalize

  private

  def normalize
    self.description = description.squish.upcase
  end
end
