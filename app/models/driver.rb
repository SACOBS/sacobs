# == Schema Information
#
# Table name: drivers
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  surname    :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#
# Indexes
#
#  index_drivers_on_user_id  (user_id)
#

class Driver < ActiveRecord::Base
  attr_reader :full_name

  to_param :full_name

  belongs_to :user
  has_and_belongs_to_many :trips

  validates :name, :surname, presence: true

  def full_name
    @full_name ||= "#{name} #{surname}".squish
  end
end
