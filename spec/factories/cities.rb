# == Schema Information
#
# Table name: cities
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  slug         :string(255)
#  user_id      :integer
#  venues_count :integer          default(0)
#
# Indexes
#
#  index_cities_on_slug     (slug) UNIQUE
#  index_cities_on_user_id  (user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :city do
    name "MyCity"
  end
end
