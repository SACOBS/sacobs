# == Schema Information
#
# Table name: trips
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  start_date :date
#  end_date   :date
#  route_id   :integer
#  bus_id     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Trip < ActiveRecord::Base
  include AttributesEmpty

  belongs_to :bus
  belongs_to :route, -> { includes(:connections) }
  has_many :stops , dependent: :destroy
  has_and_belongs_to_many :drivers

  amoeba { enable }

  accepts_nested_attributes_for :stops, reject_if: :all_blank, allow_destroy: true

  delegate :description, to: :route, prefix: true, allow_nil: true
  delegate :name, to: :bus, prefix: true, allow_nil: true

  validates :name, :start_date, :end_date, :route, :bus, presence: true
  
 end
