class ReserveBooking
  def initialize(booking, user, expiry_date)
    @booking = booking
    @related_booking = booking.main || booking.return_booking
    @user = user
    @expiry_date = expiry_date
  end

  def reserve
    Booking.transaction do
      @booking.update!(expiry_date: @expiry_date ,status: :reserved, user: @user)
      @related_booking.update!(expiry_date: @expiry_date, status: :reserved, user: @user) if @related_booking
      seating_assigner(@booking).assign
      seating_assigner(@related_booking).assign if @related_booking
    end
    true
  rescue
    false
  end

  private
  def seating_assigner(booking)
    @seating_assigner ||= SeatingAssigner.new(booking)
  end
end