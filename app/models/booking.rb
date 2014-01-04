# == Schema Information
#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  trip_id      :integer
#  price        :decimal(, )
#  status       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  quantity     :integer          default(0)
#  expiry_date  :datetime
#  client_id    :integer
#  user_id      :integer
#  reference_no :string(255)
#

class Booking < ActiveRecord::Base
  include AttributeDefaults

  enum :status, [:paid, :reserved, :cancelled, :processing]


  belongs_to :user
  belongs_to :trip
  belongs_to :client
  has_one :invoice
  has_many :passengers, dependent: :destroy
  has_and_belongs_to_many :stops, autosave: true

  accepts_nested_attributes_for :client, reject_if: :all_blank
  accepts_nested_attributes_for :passengers, reject_if: :all_blank
  accepts_nested_attributes_for :invoice, reject_if: :all_blank

  delegate :name, :start_date, :end_date, to: :trip, prefix: true

  def expired?
    self.expiry_date <= Time.zone.now
  end

  private
    def defaults
      { status: :processing }
    end
end
