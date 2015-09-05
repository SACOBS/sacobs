class CancelBooking

    delegate :stop, :trip, :quantity, to: :booking

    def initialize(booking, user)
      @booking = booking
      @user = user
    end

    def perform
      Booking.transaction do
        unassign_seats
        booking.update!(status: :cancelled, user_id: user.id)
      end
    end

    private
    attr_reader :booking, :user

    def unassign_seats
      trip.unassign_seats(stop, quantity)
    end
end