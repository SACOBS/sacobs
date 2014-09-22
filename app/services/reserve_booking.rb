class ReserveBooking
  include Service

  def initialize(booking, user)
    @booking = booking
    @related_booking = booking.main || booking.return_booking
    @user = user
  end

  def execute
    Booking.transaction do
      AssignSeating.execute(@booking.quantity, @booking.stop)
      @booking.update!(expiry_date: expiry_date , status: :reserved, user: @user)
      if @related_booking
        AssignSeating.execute(@related_booking.quantity, @related_booking.stop)
        @related_booking.update!(expiry_date: expiry_date, status: :reserved, user: @user)
      end
    end
  end

  private
  def expiry_date
    Time.zone.now.advance(hours: settings.booking_expiry_period)
  end

  def settings
    @settings ||= Setting.first
  end

end
