# == Schema Information
#
# Table name: routes
#
#  id                :integer          not null, primary key
#  cost              :decimal(8, 2)
#  distance          :integer
#  created_at        :datetime
#  updated_at        :datetime
#  name              :string(255)
#  user_id           :integer
#  connections_count :integer          default(0)
#

require 'test_helper'

class RouteTest < ActiveSupport::TestCase
  should have_many(:connections).inverse_of(:route)
  should have_many(:destinations).inverse_of(:route)

  should accept_nested_attributes_for(:connections)
  should accept_nested_attributes_for(:destinations).allow_destroy(true)

  should validate_presence_of(:name)
  should validate_presence_of(:cost)
  should validate_presence_of(:distance)
  should validate_presence_of(:destinations)

  should validate_numericality_of(:cost)
  should validate_numericality_of(:distance)

  test 'should reject connections if from_id and to_id are blank' do
    attributes = Connection.new(from_id: nil, to_id: nil)
    assert Route.nested_attributes_options[:connections][:reject_if].call(attributes)
  end

  test 'should reject destinations if attributes are blank' do
    attributes = Destination.new.attributes
    assert Route.nested_attributes_options[:destinations][:reject_if].call(attributes)
  end

  test 'should require at least 2 destinations' do
    route = routes(:eltope)

    route.destinations.build(city: cities(:east_london), sequence: 1)

    route.validate

    assert_not route.valid?
    assert_equal ['requires at least 2'], route.errors.messages[:destinations]
  end
end
