# == Schema Information
#
# Table name: routes
#
#  id            :integer          not null, primary key
#  start_city_id :integer
#  end_city_id   :integer
#  cost          :decimal(8, 2)
#  distance      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  name          :string(255)
#  slug          :string(255)
#  user_id       :integer
#
# Indexes
#
#  index_routes_on_slug  (slug) UNIQUE
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :routes do
    start_city factory: :city
    end_city factory: :city
    cost "9.99"
    distance 1
  end
end
