# == Schema Information
#
# Table name: seasonal_markups
#
#  id          :integer          not null, primary key
#  percentage  :decimal(, )
#  period_from :date
#  period_to   :date
#  active      :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer
#
# Indexes
#
#  index_seasonal_markups_on_user_id  (user_id)
#

class SeasonalDiscount < ActiveRecord::Base

  belongs_to :user
  belongs_to :passenger_type

  scope :active, -> { where(active: true) }
  scope :active_in_period, -> (date) { where(seasonal_discount[:period_from].lteq(date).and(seasonal_discount[:period_to].gteq(date))).merge(active) }


  validates_presence_of :passenger_type

  def description
    "seasonal_#{passenger_type.description}_discount".titleize
  end

  def self.seasonal_discount
    self.arel_table
  end
  private_class_method :seasonal_discount

  private
   def defaults
     { percentage: 0, period_from: Date.today, period_to: Date.tomorrow, active: true }
   end
end
