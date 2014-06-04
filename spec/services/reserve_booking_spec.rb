require 'rails_helper'

describe ReserveBooking do
  let(:user) { create(:user) }
  let(:booking){ create(:booking, status: :in_process) }
  let(:return_booking){ create(:booking, status: :in_process) }



  it 'marks the booking as reserved' do
    allow_any_instance_of(AssignSeating).to receive(:execute).and_return(nil)
    ReserveBooking.execute(booking, user, Date.tomorrow)
    booking.reload
    expect(booking).to be_reserved
  end

  it 'marks the booking and the return booking as reserved' do
    booking.has_return = true
    booking.return_booking = return_booking
    booking.save!
    booking.reload
    allow_any_instance_of(AssignSeating).to receive(:execute).and_return(nil)
    ReserveBooking.execute(booking, user, Date.tomorrow)
    return_booking.reload
    expect(return_booking).to be_reserved
  end
end