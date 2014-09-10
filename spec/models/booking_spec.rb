# == Schema Information
#
# Table name: bookings
#
#  id           :integer          not null, primary key
#  trip_id      :integer
#  price        :decimal(, )
#  status       :integer
#  created_at   :datetime
#  updated_at   :datetime
#  quantity     :integer          default(0)
#  expiry_date  :datetime
#  client_id    :integer
#  user_id      :integer
#  reference_no :string(255)
#  main_id      :integer
#  has_return   :boolean          default(FALSE)
#  stop_id      :integer
#  sequence_id  :integer
#
# Indexes
#
#  index_bookings_on_client_id  (client_id)
#  index_bookings_on_main_id    (main_id)
#  index_bookings_on_stop_id    (stop_id)
#  index_bookings_on_trip_id    (trip_id)
#  index_bookings_on_user_id    (user_id)
#

require 'rails_helper'

describe Booking, type: :model do

  describe 'relationships' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:trip) }
    it { is_expected.to belong_to(:stop) }
    it { is_expected.to belong_to(:client) }
    it { is_expected.to belong_to(:main).conditions('where status != cancelled').class_name('Booking').with_foreign_key(:main_id).touch(true) }

    it { is_expected.to have_one(:return_booking).conditions('where status != cancelled').class_name('Booking').with_foreign_key(:main_id) }
    it { is_expected.to have_one(:invoice).dependent(:destroy) }
    it { is_expected.to have_one(:payment_detail).dependent(:destroy) }

    it { is_expected.to have_many(:passengers).dependent(:destroy) }


    it { is_expected.to accept_nested_attributes_for(:client) }
    it { is_expected.to accept_nested_attributes_for(:passengers) }
    it { is_expected.to accept_nested_attributes_for(:invoice) }
    it { is_expected.to accept_nested_attributes_for(:return_booking) }

    it { is_expected.to delegate_method(:trip_name).to(:trip).as(:name) }
    it { is_expected.to delegate_method(:trip_start_date).to(:trip).as(:start_date) }
    it { is_expected.to delegate_method(:trip_end_date).to(:trip).as(:end_date) }


  end

  describe 'callbacks' do
    it { is_expected.to callback(:init_return_booking).before(:save) }
    it { is_expected.to callback(:set_shared_booking_data).before(:save) }
    it { is_expected.to callback(:generate_reference).before(:save) }
    it { is_expected.to callback(:check_expiration).after(:find) }
  end

  describe 'callback methods' do

    describe '#init_return_booking' do
      context 'has_return is true and return booking does not exist' do
        it 'builds a return booking' do
          booking = build_stubbed(:booking, has_return: true)
          booking.send(:init_return_booking)
          expect(booking.return_booking).to_not be_nil
        end
      end
      context 'has_return is true and return booking does exist' do
        it 'does not build a return booking' do
          booking = build(:booking, has_return: true)
          return_booking = build(:booking)
          booking.return_booking = return_booking
          booking.send(:init_return_booking)
          expect(booking.return_booking).to eql(return_booking)
        end
      end
    end

    describe '#set_shared_booking_data' do
        it 'sets the client and passengers for the return booking' do
          booking = build(:booking, passengers: build_list(:passenger, 2))
          return_booking = build(:booking, client: nil)
          booking.return_booking = return_booking
          booking.send(:set_shared_booking_data)
          expect(return_booking.client).to eql(booking.client)
          expect(return_booking.passengers.size).to eql(booking.passengers.size)
        end
    end

    describe '#generate_reference' do
      describe 'sets the sequence_id and reference_no for a reserved booking' do
        let(:booking){ build_stubbed(:booking, reference_no: nil, sequence_id: nil) }

        context 'booking is reserved' do
          it 'sets the sequence_id and reference_no' do
            booking.status = :reserved
            booking.send(:generate_reference)
            expect(booking.sequence_id).to_not be_nil
            expect(booking.reference_no).to_not be_nil
          end
        end

        context 'booking is not reserved' do
          it 'does not set the  sequence_id and reference_no' do
            booking.status = :in_process
            booking.send(:generate_reference)
            expect(booking.sequence_id).to be_nil
            expect(booking.reference_no).to be_nil
          end
        end
      end
    end

    describe '#check_expiration' do
      describe 'sets the expired flag based on the expiry date' do
        let(:booking){ build_stubbed(:booking) }

        context 'booking is expired' do
          it 'sets expired flag to true' do
            booking.expiry_date = Time.zone.now - 1.day
            booking.send(:check_expiration)
            expect(booking.expired).to be true
          end
        end

        context 'booking is not expired' do
          it 'sets expired flag to false' do
            booking.expiry_date = Time.zone.now + 1.day
            booking.send(:check_expiration)
            expect(booking.expired).to be false
          end
        end
      end
    end
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }

    describe 'quantity does not exceed available seating' do
      let(:stop){ build_stubbed(:stop, available_seats: 10)  }
      subject(:booking) { build_stubbed(:booking, stop: stop) }

      context 'valid quantity' do
        before { booking.quantity = 1 }

        it { is_expected.to be_valid }
      end

      context 'invalid quantity' do
        before { booking.quantity = 11 }

        it { is_expected.not_to be_valid }
      end
    end
  end


end
