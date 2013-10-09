# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_date :date
#  end_date   :date
#  route_id   :integer
#  bus_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Trip < ActiveRecord::Base
  belongs_to :bus
  belongs_to :route, -> { includes(:connections) }
  has_many :stops , dependent: :destroy
end
