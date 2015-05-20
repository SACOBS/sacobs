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
# Indexes
#
#  index_routes_on_user_id  (user_id)
#

class Route < ActiveRecord::Base
  to_param :name

  belongs_to :user

  has_many :destinations, dependent: :destroy, inverse_of: :route, before_add: :reorder_destinations do
    def beyond(sequence)
      where('sequence > ?', sequence)
    end
  end

  has_many :connections, dependent: :destroy, inverse_of: :route

  accepts_nested_attributes_for :connections, reject_if: :all_blank
  accepts_nested_attributes_for :destinations, reject_if: :all_blank, allow_destroy: true

  validates :name, :cost, :distance, presence: true
  validates :cost, :distance, numericality: true
  validates :destinations, presence: true, length: { minimum: 2, too_short: 'is too short (at least %{count} destinations required)' }

  before_save :set_connection_costs, if: :cost_changed?
  after_save :generate_connections, if: proc { |route| route.destinations.any? { |d| d.previous_changes.any? } }
  after_update { touch }

  def copy
    copy = dup
    copy.name = "Copy of #{name}"
    destinations.map { |d| copy.destinations.build(city: d.city, sequence: d.sequence) }
    connections.each do |original|
      from = copy.destinations.find { |d| d.city == original.from.city }
      to = copy.destinations.find { |d| d.city == original.to.city }
      copy.connections.build(from: from, to: to)
    end
    copy
  end

  def reverse_copy
    reverse_copy = dup
    reverse_copy.name = "Reverse of #{name}"
    destinations.reverse.map.with_index(1) { |original, index| reverse_copy.destinations.build(city: original.city, sequence: index) }
    connections.reverse_each do |original|
      from = reverse_copy.destinations.find { |d| d.city == original.to.city }
      to = reverse_copy.destinations.find { |d| d.city == original.from.city }
      reverse_copy.connections.build(from: from, to: to)
    end
    reverse_copy
  end

  def start_city
    destinations.first.city
  end

  def end_city
    destinations.last.city
  end

  private

  def reorder_destinations(destination)
    if destinations.exists?(sequence: destination.sequence)
      destinations.beyond(destination.sequence.pred).each { |shifting| shifting.increment!(:sequence) }
    end
  end

  def set_connection_costs
    connections.each { |c| c.cost = ((cost * (c.percentage / 100)) / 5.0).ceil * 5 }
  end

  def generate_connections
    destinations.each do |from|
      destinations.drop(from.sequence).each { |to| connections.where(from: from, to: to).first_or_create }
    end
  end
end
