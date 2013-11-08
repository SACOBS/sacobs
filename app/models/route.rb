# == Schema Information
#
# Table name: routes
#
#  id            :integer          not null, primary key
#  start_city_id :integer
#  end_city_id   :integer
#  cost          :decimal(8, 2)
#  distance      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  name          :string(255)
#  slug          :string(255)
#

class Route < ActiveRecord::Base
  include AttributesEmpty
  extend FriendlyId

  friendly_id :name, use: :slugged


  belongs_to :start_city, class_name: :City
  belongs_to :end_city, class_name: :City

  has_many :connections, dependent: :destroy, autosave: true

  accepts_nested_attributes_for :connections,  reject_if: :all_blank, allow_destroy: true

  validates :start_city, :end_city, :cost, :distance, presence: true

  delegate :name, to: :start_city, prefix: true, allow_nil: true
  delegate :name, to: :end_city, prefix: true, allow_nil: true

  before_save :set_name
  before_update :mark_children_for_change

  protected
  def set_name
    self.name = "#{start_city_name} to #{end_city_name}"
  end

  def mark_children_for_change
    if self.distance_changed? || self.cost_changed?
      self.connections.each do |c|
        c.percentage_will_change!
        c.cost_will_change!
      end
    end
  end
end
