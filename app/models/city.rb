# == Schema Information
#
# Table name: cities
#
#  id      :integer          not null, primary key
#  name    :string(255)
#  slug    :string(255)
#  user_id :integer
#
# Indexes
#
#  index_cities_on_slug  (slug) UNIQUE
#

class City < ActiveRecord::Base
  extend FriendlyId

  default_scope -> { order(name: :asc) }

  friendly_id :name, use: :slugged

  belongs_to :user

  has_many :venues, dependent: :destroy
  accepts_nested_attributes_for :venues, reject_if: :all_blank, allow_destroy: true

  validates :name, presence: true
end
