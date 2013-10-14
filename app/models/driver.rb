# == Schema Information
#
# Table name: drivers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Driver < ActiveRecord::Base
  has_and_belongs_to_many :trips

 validates :name, :surname, presence: true

 def to_s
  "#{self.name} #{self.surname}".titleize
 end

end
