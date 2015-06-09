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
  include CollectionCacheable

  to_param :name

  has_many :destinations, -> { includes(:city) } ,dependent: :destroy, inverse_of: :route, before_add: :reorder_destinations do
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

  before_save :normalize_name
  before_save :generate_connections
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
    destinations.first.name
  end

  def end_city
    destinations.last.name
  end

  private

  def normalize_name
    self.name = name.strip.upcase
  end

  def reorder_destinations(destination)
    if destinations.exists?(sequence: destination.sequence)
      destinations.beyond(destination.sequence.pred).each { |shifting| shifting.increment!(:sequence) }
    end
  end

  def generate_connections
    if destinations.any?(&:changed?)
      destinations.each do |from|
        destinations.drop(from.sequence).each { |to| connections.find_or_initialize_by(from: from, to: to) }
      end
    end
  end
end
