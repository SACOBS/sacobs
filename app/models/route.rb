# == Schema Information
#
# Table name: routes
#
#  id         :integer          not null, primary key
#  cost       :decimal(8, 2)
#  distance   :integer
#  created_at :datetime
#  updated_at :datetime
#  name       :string(255)
#  user_id    :integer
#

class Route < ActiveRecord::Base
  to_param :name

  has_many :destinations, -> { includes(:city) }, dependent: :destroy, inverse_of: :route

  has_many :connections, dependent: :destroy, inverse_of: :route

  accepts_nested_attributes_for :connections, reject_if: :all_blank
  accepts_nested_attributes_for :destinations, reject_if: :all_blank, allow_destroy: true

  validates :name, :cost, :distance, presence: true
  validates :cost, :distance, numericality: true
  validates :destinations, presence: true, length: { minimum: 2, too_short: 'is too short (at least %{count} destinations required)' }

  before_save :normalize
  after_save :generate_connections

  def copy
    self.class.skip_callback(:save, :before, :generate_connections)
    object = dup
    object.name = "Copy of #{name}"
    destinations.map { |d| object.destinations.build(city: d.city, sequence: d.sequence) }
    connections.each do |original|
      from = object.destinations.find { |destination| destination.city == original.from.city }
      to = object.destinations.find { |destination| destination.city == original.to.city }
      object.connections.build(from: from, to: to, cost: original.cost, percentage: original.percentage, distance: original.distance, leaving: original.leaving, arriving: original.arriving)
    end
    yield(object) if block_given?
    object.save
    self.class.set_callback(:save, :before, :generate_connections)
    object
  end

  def reverse_copy
    self.class.skip_callback(:save, :before, :generate_connections)
    object = dup
    object.name = "Reverse of #{name}"
    destinations.reverse.map.with_index(1) { |original, index| object.destinations.build(city: original.city, sequence: index) }
    connections.reverse_each do |original|
      from = object.destinations.find { |d| d.city == original.to.city }
      to = object.destinations.find { |d| d.city == original.from.city }
      object.connections.build(from: from, to: to, percentage: original.percentage, cost: original.cost, distance: original.distance, leaving: original.leaving, arriving: original.arriving)
    end
    yield(object) if block_given?
    object.save
    self.class.set_callback(:save, :before, :generate_connections)
    object
  end

  private

  def normalize
    self.name = name.squish.upcase
  end

  def generate_connections
    destinations.each do |from|
      destinations.drop(from.sequence).each { |to| connections.find_or_initialize_by(from_id: from.id, to_id: to.id).save! }
    end
  end
end
