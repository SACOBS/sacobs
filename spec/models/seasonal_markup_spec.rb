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

require 'spec_helper'

describe SeasonalMarkup do
  pending "add some examples to (or delete) #{__FILE__}"
end
