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

  has_many :destinations, dependent: :destroy, before_add: :reorder_sequences, after_add: :create_connections
  has_many :connections, dependent: :destroy

  accepts_nested_attributes_for :connections, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :destinations, reject_if: :all_blank, allow_destroy: true

  validates :name, :cost, :distance, presence: true, on: :update

  before_save :set_connection_costs, if: :cost_changed?
  after_update { touch }

  def copy
    copy = dup
    copy.name = "Copy of #{name}"
    copy.destinations = destinations.map(&:dup)
    connections.map(&:dup).each do |connection|
      from = copy.destinations.select {|d| d.city == connection.from_city }.first
      to = copy.destinations.select {|d| d.city == connection.to_city }.first
      connection.from = from
      connection.to = to
      copy.connections << connection
    end
    copy
  end

  def reverse_copy
    reverse_copy = dup
    reverse_copy.name = "Reverse of #{name}"
    reverse_copy.destinations << destinations.map(&:dup).reverse.each_with_index { |d, index | d.sequence = index.next }
    connections.map(&:dup).each do |connection|
      from = reverse_copy.destinations.select {|d| d.city == connection.to_city }.first
      to = reverse_copy.destinations.select {|d| d.city == connection.from_city }.first
      connection.from = from
      connection.from = to
      reverse_copy.connections << connection
    end
    reverse_copy
  end

  def start_city
    destinations.first.try(:city)
  end

  def end_city
    destinations.last.try(:city)
  end

  private
  def reorder_sequences(destination)
    destinations.where('sequence > ?', destination.sequence.pred).each { |shifting| shifting.increment!(:sequence) } if destinations.exists?(sequence: destination.sequence)
    save
  end

  def create_connections(destination)
    if destination.persisted?
     destinations.each do |from|
       destinations.drop(from.sequence).each { |to| connections.find_or_create_by(from: from, to: to) }
     end
    end
  end

  def set_connection_costs
    connections.each { |c| c.cost = ((cost * (c.percentage / 100)) / 5.0).ceil * 5 }
  end
end
