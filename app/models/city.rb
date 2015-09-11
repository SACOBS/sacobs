# == Schema Information
#
# Table name: cities
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  user_id      :integer
#  venues_count :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_cities_on_name  (name)
#

class City < ActiveRecord::Base
  default_scope { order(name: :asc) }

  to_param :name

  has_many :venues

  accepts_nested_attributes_for :venues, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true

  before_save :normalize

  private

  def normalize
    self.name = name.squish.upcase
  end
end
