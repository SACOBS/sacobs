require 'spec_helper'

describe SeasonalMarkup, :type => :model do
 it {is_expected.to belong_to(:user) }

 describe 'class methods' do
   describe '.active' do
     it 'returns active markups' do
       active_markup = create(:seasonal_markup, active: true)
       non_active_markup = create(:seasonal_markup, active: false)
       result = SeasonalMarkup.active
       expect(result).to eq [active_markup]
     end
   end

   describe '.in_period' do
     it 'returns markups that apply for the passed in date' do
       markup_in_period = create(:seasonal_markup, period_from: Date.today, period_to: Date.today + 3.days)
       markup_not_in_period =  create(:seasonal_markup, period_from: Date.today + 1.year, period_to: Date.today + 2.years)
       result = SeasonalMarkup.in_period(Date.today)
       expect(result).to eq [markup_in_period]
     end
   end
 end
end