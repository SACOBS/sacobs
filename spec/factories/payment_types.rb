# == Schema Information
#
# Table name: payment_types
#
#  id          :integer          not null, primary key
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment_type, :class => 'PaymentTypes' do
    description "MyString"
  end
end
