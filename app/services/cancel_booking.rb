class CancelBooking
  def initialize(booking, user)
    @booking = booking
    @user = user
  end

  def cancel
    Booking.transaction do
      seating_assigner(@booking).unassign
      @booking.update!(status: :cancelled, user: @user)
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