# == Schema Information
#
# Table name: seasonal_discounts
#
#  id                :integer          not null, primary key
#  percentage        :decimal(, )
#  period_from       :date
#  period_to         :date
#  active            :boolean          default(FALSE)
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

require 'rails_helper'

describe SeasonalDiscount, :type => :model do
 it {is_expected.to belong_to(:user) }

 describe 'class methods' do
   describe '.active' do
     it 'returns active markups' do
       active_markup = create(:seasonal_discount, active: true)
       non_active_markup = create(:seasonal_discount, active: false)
       result = SeasonalDiscount.active
       expect(result).to eq [active_markup]
     end
   end

   describe '.in_period' do
     it 'returns markups that apply for the passed in date' do
       markup_in_period = create(:seasonal_discount, period_from: Date.today, period_to: Date.today + 3.days)
       markup_not_in_period =  create(:seasonal_discount, period_from: Date.today + 1.year, period_to: Date.today + 2.years)
       result = SeasonalDiscount.in_period(Date.today)
       expect(result).to eq [markup_in_period]
     end
   end
 end
end
