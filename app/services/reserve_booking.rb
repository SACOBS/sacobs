class ReserveBooking
  include Service

  def initialize(booking, user)
    @bookings = [booking, booking.main, booking.return_booking].compact
    @user = user
  end

  def execute
    Booking.transaction do
      @bookings.each do |booking|
        AssignSeating.execute(booking.quantity, booking.stop)
        booking.update!(expiry_date: expiry_date, status: :reserved, user: @user)
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
