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
  default_scope { order(description: :asc) }

  validates :description, presence: true

  before_create do
    description.try(:downcase!)
  end

  def to_label
    description.titleize
  end
end
