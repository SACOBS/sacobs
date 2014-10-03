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
  validates :description, presence: true

  before_create :format_description

  def to_label
    description.titleize
  end

  protected

  def format_description
    description.downcase!
  end
end
