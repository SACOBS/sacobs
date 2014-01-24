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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :seasonal_markup do
    percentage "9.99"
    from "2014-01-23"
    to "2014-01-23"
    active false
  end
end
