require 'spec_helper'

describe Booking do

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:trip) }
    it { should belong_to(:stop) }
    it { should belong_to(:client) }
    it { should belong_to(:main).conditions('where status != cancelled').class_name('Booking').with_foreign_key(:main_id).touch(true) }

    it { should have_one(:return_booking).conditions('where status != cancelled').class_name('Booking').with_foreign_key(:main_id) }
    it { should have_one(:invoice).dependent(:destroy) }
    it { should have_one(:payment_detail).dependent(:destroy) }

    it { should have_many(:passengers).dependent(:destroy) }


    it { should accept_nested_attributes_for(:client) }
    it { should accept_nested_attributes_for(:passengers) }
    it { should accept_nested_attributes_for(:invoice) }
    it { should accept_nested_attributes_for(:return_booking) }

    it { should delegate_method(:trip_name).to(:trip).as(:name) }
    it { should delegate_method(:trip_start_date).to(:trip).as(:start_date) }
    it { should delegate_method(:trip_end_date).to(:trip).as(:end_date) }


  end

  describe 'callbacks' do
    it { should callback(:init_return_booking).before(:save) }
    it { should callback(:set_shared_booking_data).before(:save) }
    it { should callback(:generate_reference).before(:save) }
    it { should callback(:check_expiration).after(:find) }
  end

  describe 'callback methods' do

    describe '#init_return_booking' do
      context 'has_return is true and return booking does not exist' do
        it 'builds a return booking' do
          booking = build(:booking, has_return: true)
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
        let(:booking){ build(:booking, reference_no: nil, sequence_id: nil) }

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
        let(:booking){ build(:booking) }

        context 'booking is expired' do
          it 'sets expired flag to true' do
            booking.expiry_date = Time.zone.now - 1.day
            booking.send(:check_expiration)
            expect(booking.expired).to be_true
          end
        end

        context 'booking is not expired' do
          it 'sets expired flag to false' do
            booking.expiry_date = Time.zone.now + 1.day
            booking.send(:check_expiration)
            expect(booking.expired).to be_false
          end
        end
      end
    end
  end


  describe 'validations' do
    it { should validate_numericality_of(:quantity).is_greater_than(0) }

    describe 'quantity does not exceed available seating' do
      let(:stop){ build(:stop, available_seats: 10)  }
      subject(:booking) { build(:booking, stop: stop) }

      context 'valid quantity' do
        before(:each) { booking.quantity = 1 }

        it { should be_valid }
      end

      context 'invalid quantity' do
        before(:each) { booking.quantity = 11 }

        it { should_not be_valid }
      end
    end
  end


end
