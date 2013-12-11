# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  city_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Venue < ActiveRecord::Base
  belongs_to :city

  validates :name, :city, presence: true
end
