# == Schema Information
#
# Table name: seasonal_discounts
#
#  id                :integer          not null, primary key
#  percentage        :decimal(, )
#  period_from       :date
#  period_to         :date
#  active            :boolean          default(TRUE)
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
  belongs_to :passenger_type, required: true

  scope :active, -> { where(active: true) }
  scope :applicable, -> { where(arel_table[:period_from].gteq(Time.zone.today)) }
  scope :active_in_period, -> (date) { where(arel_table[:period_from].lteq(date).and(arel_table[:period_to].gteq(date))).merge(active) }

  validates :name, :period_from, :period_to, :percentage, presence: true

  before_save :normalize

  def description
    @description ||= "#{name}(seasonal_#{passenger_type.description}_discount)".titleize
  end

  protected
  def normalize
    self.name = name.squish.upcase
  end

end
