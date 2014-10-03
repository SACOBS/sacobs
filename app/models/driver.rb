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
# Indexes
#
#  index_drivers_on_slug     (slug) UNIQUE
#  index_drivers_on_user_id  (user_id)
#

class Driver < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user
  has_and_belongs_to_many :trips

  friendly_id :full_name, use: :slugged

  validates :name, :surname, presence: true

  def full_name
    "#{name} #{surname}"
  end

  private

  def should_generate_new_friendly_id?
    name_changed? || surname_changed?
  end
end
