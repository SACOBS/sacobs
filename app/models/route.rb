# == Schema Information
#
# Table name: routes
#
#  id                :integer          not null, primary key
#  cost              :decimal(8, 2)
#  distance          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  name              :string(255)
#  slug              :string(255)
#  user_id           :integer
#  connections_count :integer          default(0)
#
# Indexes
#
#  index_routes_on_slug     (slug) UNIQUE
#  index_routes_on_user_id  (user_id)
#

class Route < ActiveRecord::Base
  include AttributesEmpty
  extend FriendlyId

  friendly_id :name, use: :slugged


  belongs_to :user
  has_many :destinations, -> { includes(:city).order(:sequence) }, dependent: :destroy, inverse_of: :route
  has_many :connections, -> { includes(:from, :to) }, dependent: :destroy, autosave: true, inverse_of: :route

  amoeba do
    nullify :connections_count
    prepend name: 'Copy of'
    enable
  end

  accepts_nested_attributes_for :connections,  reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :destinations, reject_if: :all_blank, allow_destroy: true

  validates :name, :cost, :distance, presence: true, on: :update

  before_save :set_connection_costs, if: :cost_changed?

  def start_city
    self.destinations.first.city unless self.destinations.empty?
  end

  def end_city
    self.destinations.last.city unless self.destinations.empty?
  end

  private
   def should_generate_new_friendly_id?
     name_changed?
   end

   def set_connection_costs
     self.connections.each do |c|
       c.cost = ((self.cost * (c.percentage / 100)) / 5.0).ceil * 5
     end
   end
end
