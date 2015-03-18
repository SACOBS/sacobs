# == Schema Information
#
# Table name: seasonal_discounts
#
#  id                :integer          not null, primary key
#  percentage        :decimal(, )
#  period_from       :date
#  period_to         :date
#  active            :boolean          default("false")
#  created_at        :datetime
#  updated_at        :datetime
#  user_id           :integer
#  passenger_type_id :integer
#  name              :string(255)
#
# Indexes
#
#  index_seasonal_discounts_on_passenger_type_id  (passenger_type_id)
#  index_seasonal_discounts_on_user_id            (user_id)
#

class SeasonalDiscount < ActiveRecord::Base
  belongs_to :user
  belongs_to :passenger_type

  scope :active, -> { where(active: true) }
  scope :applicable, -> { where(arel_table[:period_from].gteq(Time.zone.today)) }
  scope :active_in_period, -> (date) { where(arel_table[:period_from].lteq(date).and(arel_table[:period_to].gteq(date))).merge(active) }

  validates :name, :passenger_type, presence: true

  delegate :description, to: :passenger_type, prefix: true

  def description
    "#{name}(seasonal_#{passenger_type_description}_discount)".titleize
  end

  private

  def defaults
    { percentage: 0, period_from: Date.today, period_to: Date.tomorrow, active: true }
  end
end
