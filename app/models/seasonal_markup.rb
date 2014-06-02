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

class SeasonalMarkup < ActiveRecord::Base

  belongs_to :user


  scope :active, -> { where(active: true) }
  scope :in_period, -> (date) { where(seasonal_markup[:period_from].lteq(date).and(seasonal_markup[:period_to].gteq(date))) }

  def self.seasonal_markup
    self.arel_table
  end
  private_class_method :seasonal_markup

  private
   def defaults
     { percentage: 0, period_from: Date.today, period_to: Date.tomorrow }
   end
end
