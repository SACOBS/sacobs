# == Schema Information
#
# Table name: scriptures
#
#  id         :integer          not null, primary key
#  verse      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :scripture do
    verse "MyString"
  end
end
