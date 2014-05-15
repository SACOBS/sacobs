class ReserveBooking
  include Service

  def initialize(booking, user, expiry_date)
    @booking = booking
    @related_booking = booking.main || booking.return_booking
    @user = user
    @expiry_date = expiry_date
  end

  def execute
    Booking.transaction do
      AssignSeating.execute(@booking.quantity, @booking.stop)
      @booking.update!(expiry_date: @expiry_date ,status: :reserved, user: @user)
      if @related_booking
        AssignSeating.execute(@related_booking.quantity, @related_booking.stop)
        @related_booking.update!(expiry_date: @expiry_date, status: :reserved, user: @user)
      end
    end
  end

end