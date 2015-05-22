# == Schema Information
#
# Table name: passenger_types
#
#  id          :integer          not null, primary key
#  description :character varyin
#  created_at  :timestamp withou
#  updated_at  :timestamp withou
#

class PassengerType < ActiveRecord::Base
  include CollectionCacheable

  default_scope { order(description: :asc) }

  validates :description, presence: true

  before_create do
    self.description = description.upcase
  end
end
