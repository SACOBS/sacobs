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
  include AttributeDefaults

  belongs_to :user


  scope :active, -> { where(active: true) }
  scope :in_period, ->(date) { where(':date > period_from AND :date < period_to', {date: date})  }


  private
   def defaults
     { percentage: 0, period_from: Date.today, period_to: Date.tomorrow }
   end
end
