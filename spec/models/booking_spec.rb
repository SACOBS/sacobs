# == Schema Information
#
# Table name: bookings
#
#  id                :integer          not null, primary key
#  trip_id           :integer
#  price             :decimal(, )      default(0.0)
#  status            :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#  quantity          :integer          default(0)
#  expiry_date       :datetime
#  client_id         :integer
#  user_id           :integer
#  reference_no      :string(255)
#  main_id           :integer
#  stop_id           :integer
#  sequence_id       :integer
#  archived          :boolean          default(FALSE)
#  archived_at       :datetime
#  payment_detail_id :integer
#
# Indexes
#
#  index_bookings_on_archived   (archived)
#  index_bookings_on_client_id  (client_id)
#  index_bookings_on_main_id    (main_id)
#  index_bookings_on_stop_id    (stop_id)
#  index_bookings_on_trip_id    (trip_id)
#

require "rails_helper"

RSpec.describe Booking, type: :model do
  it { should belong_to(:trip).counter_cache(:true) }
  it { should belong_to(:stop) }
  it { should belong_to(:client) }
  it { should belong_to(:main).class_name("Booking").with_foreign_key(:main_id) }
  it { should have_one(:return_booking).class_name("Booking").with_foreign_key(:main_id) }
  it { should have_one(:invoice).dependent(:delete) }
  it { should have_one(:payment_detail).dependent(:delete) }
  it { should have_many(:passengers).dependent(:delete_all) }

  it { should accept_nested_attributes_for(:client) }
  it { should accept_nested_attributes_for(:invoice) }
  it { should accept_nested_attributes_for(:passengers) }
  it { should accept_nested_attributes_for(:return_booking) }

  it { should validate_numericality_of(:quantity).is_greater_than(0) }

  describe "validates the quantity does not exceed available seating" do
    it "is valid when quantity does not exceed available seats" do
      booking = build(:booking, quantity: 1)
      allow(booking).to receive_message_chain("stop.available_seats") { 1 }
      expect(booking).to be_valid
    end

    it "is not valid when quantity exceeds available seats" do
      booking = build(:booking, quantity: 2)
      allow(booking).to receive_message_chain("stop.available_seats") { 1 }
      expect(booking).to_not be_valid
    end
  end

  describe "callbacks" do
  end
end
