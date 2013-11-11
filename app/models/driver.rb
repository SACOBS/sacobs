# == Schema Information
#
# Table name: drivers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  slug       :string(255)
#  user_id    :integer
#

class Driver < ActiveRecord::Base
  extend FriendlyId
  has_and_belongs_to_many :trips

  friendly_id :full_name, use: :slugged


  validates :name, :surname, presence: true
  validates :name, length: { maximum: 5 }

 def full_name
  "#{self.name} #{self.surname}"
 end

end
