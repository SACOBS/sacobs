# == Schema Information
#
# Table name: buses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  capacity   :integer
#  year       :string(255)
#  model      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Bus < ActiveRecord::Base
  validates :name, :capacity, :year, :model, presence: true
end
