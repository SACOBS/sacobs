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
#  user_id           :integer
#  connections_count :integer          default(0)
#

class Route < ActiveRecord::Base
  to_param :name

  with_options inverse_of: :route do
    has_many :destinations
    has_many :connections
  end

  accepts_nested_attributes_for :connections,
                                reject_if: proc {|attrs| [attrs["from_id"], attrs["to_id"]].all?(&:blank?) }

  accepts_nested_attributes_for :destinations,
                                allow_destroy: true,
                                reject_if:     :all_blank

  validates :name, :cost, :distance, :destinations, presence: true
  validates :cost, :distance, numericality: true
  validates :destinations, length: {minimum: 2, too_short: "requires at least %{count}"}

  before_save :normalize

  private

  def normalize
    self.name = name.squish.upcase
  end
end
