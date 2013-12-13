class Destination < ActiveRecord::Base
  belongs_to :city
  belongs_to :route

  validates :order, :route, :city, presence: true
end
