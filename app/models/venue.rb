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
# Indexes
#
#  index_venues_on_city_id  (city_id)
#

class Venue < ActiveRecord::Base
  belongs_to :city, counter_cache: true, touch: true

  validates :name, presence: true
end
