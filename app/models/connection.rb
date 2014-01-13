# == Schema Information
#
# Table name: connections
#
#  id         :integer          not null, primary key
#  distance   :integer
#  created_at :datetime
#  updated_at :datetime
#  route_id   :integer
#  percentage :decimal(2, 5)
#  cost       :decimal(8, 2)
#  name       :string(255)
#  from_id    :integer
#  to_id      :integer
#
# Indexes
#
#  index_connections_on_from_id   (from_id)
#  index_connections_on_route_id  (route_id)
#  index_connections_on_to_id     (to_id)
#

class Connection < ActiveRecord::Base
  include AttributeDefaults

  belongs_to :route, counter_cache: true
  belongs_to :from, -> {includes(:city)}, class_name: :Destination
  belongs_to :to,-> {includes(:city)} ,class_name: :Destination

  validates :route, :from, :to, presence: true

  before_save :set_name


  private
   def defaults
     { distance: 0, cost: 0, percentage: 0 }
   end

  protected
    def set_name
      self.name = "#{self.from.name} to #{self.to.name}"
    end

end
