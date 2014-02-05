class CancelBooking
  def initialize(booking, user)
    @booking = booking
    @user = user
  end

  def cancel
    Booking.transaction do
      @booking.update!(status: :cancelled, user: @user)
      seating_assigner(@booking).unassign
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