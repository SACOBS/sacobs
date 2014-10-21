class ConfirmBooking
  include Service

  def initialize(booking, user)
    @booking = booking
    @related_booking = booking.main || booking.return_booking
    @user = user
  end

  def execute
    Booking.transaction do
      raise ActiveRecord::Rollback unless confirm_booking && confirm_related_booking
    end
  end

  private

  def confirm_booking
    @booking.user = @user
    @booking.confirm
  end

  def confirm_related_booking
    return true unless @related_booking
    @related_booking.user = @user
    @related_booking.confirm
  end
end
