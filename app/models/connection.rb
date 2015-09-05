# == Schema Information
#
# Table name: connections
#
#  id         :integer          not null, primary key
#  distance   :integer          default(0)
#  created_at :datetime
#  updated_at :datetime
#  route_id   :integer
#  percentage :decimal(5, 2)    default(0.0)
#  cost       :decimal(8, 2)    default(0.0)
#  name       :string(255)
#  from_id    :integer
#  to_id      :integer
#  leaving    :time             default(2000-01-01 08:28:02 UTC)
#  arriving   :time             default(2000-01-01 08:28:02 UTC)
#
# Indexes
#
#  index_connections_on_from_id   (from_id)
#  index_connections_on_route_id  (route_id)
#  index_connections_on_to_id     (to_id)
#

class Connection < ActiveRecord::Base
  default_scope { order(:created_at) }

  belongs_to :route
  belongs_to :from, -> { includes(:city) }, class_name: :Destination
  belongs_to :to, -> { includes(:city) }, class_name: :Destination

  validates :route, :from, :to, :leaving, :arriving, presence: true
  validates :cost, :percentage, presence: true, numericality: true

  after_initialize :set_defaults, if: :new_record?
  before_create :set_name

  delegate :city_name, :city_venues, to: :from, prefix: true
  delegate :city_name, :city_venues, to: :to, prefix: true

  private
  def set_defaults
    self.leaving = Time.current
    self.arriving = Time.current
  end

  def set_name
    self.name = "#{from_city_name} to #{to_city_name}"
  end
end
