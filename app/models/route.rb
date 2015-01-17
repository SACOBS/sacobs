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
#  slug       :string(255)
#  user_id    :integer
#
# Indexes
#
#  index_routes_on_slug     (slug) UNIQUE
#  index_routes_on_user_id  (user_id)
#

class Route < ActiveRecord::Base

  to_param :name

  belongs_to :user

  has_many :destinations, dependent: :destroy
  has_many :connections, -> { includes(:from, :to).order(:from_id) }, dependent: :delete_all

  amoeba do
    enable
    prepend name: 'Copy of'
    clone [:connections, :destinations]
  end


  with_options reject_if: :all_blank, allow_destroy: true do |assoc|
    assoc.accepts_nested_attributes_for :connections
    assoc.accepts_nested_attributes_for :destinations
  end

  validates :name, :cost, :distance, presence: true, on: :update

  before_save :set_connection_costs, if: :cost_changed?
  after_update { touch }

  def copy
    dup.tap do |copy|
      copy.destinations << destinations.map(&:dup)
      copy.connections << connections.map(&:dup)
    end
  end

  def start_city
    destinations.first.city unless destinations.empty?
  end

  def end_city
    destinations.last.city unless destinations.empty?
  end

  private

  def set_connection_costs
    connections.each do |c|
      c.cost = ((cost * (c.percentage / 100)) / 5.0).ceil * 5
    end
  end
end
