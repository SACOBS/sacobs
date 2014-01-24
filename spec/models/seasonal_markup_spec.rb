# == Schema Information
#
# Table name: seasonal_markups
#
#  id         :integer          not null, primary key
#  percentage :decimal(, )
#  from       :date
#  to         :date
#  active     :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

require 'spec_helper'

describe SeasonalMarkup do
  pending "add some examples to (or delete) #{__FILE__}"
end
