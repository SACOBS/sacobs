class ReserveBooking
  def initialize(booking, user, expiry_date)
    @booking = booking
    @related_booking = booking.main || booking.return_booking
    @user = user
    @expiry_date = expiry_date
  end

  def reserve
    Booking.transaction do
      AssignSeating.execute(@booking.quantity, @booking.stop)
      @booking.update!(expiry_date: @expiry_date ,status: :reserved, user: @user)
      AssignSeating.execute(@related_booking.quantity, @related_booking.stop) if @related_booking
      @related_booking.update!(expiry_date: @expiry_date, status: :reserved, user: @user) if @related_booking
    end
    true
  rescue
    false
  end

end