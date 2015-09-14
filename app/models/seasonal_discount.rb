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
  scope :available, -> { where(arel_table[:period_from].gteq(Time.zone.today)) }
  scope :applicable, -> { active.where('period_from >= :date and period_to <= :date', date: Date.current)}

  validates :name, :period_from, :period_to, :percentage, presence: true

  before_save :normalize

  protected

  def normalize
    self.name =  "#{name} discount - #{percentage}%".squish.upcase
  end
end
