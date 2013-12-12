# == Schema Information
#
# Table name: cities
#
#  id      :integer          not null, primary key
#  name    :string(255)
#  slug    :string(255)
#  user_id :integer
#
# Indexes
#
#  index_cities_on_slug  (slug) UNIQUE
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    name "MyCity"
  end
end
