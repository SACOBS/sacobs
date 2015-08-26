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

  def description=(value)
    value.squish!.upcase! if value.present?
    super(value)
  end
end
