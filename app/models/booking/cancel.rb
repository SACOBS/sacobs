
class Booking::Cancel
  delegate :stop, :trip, :quantity, to: :booking

  def self.perform(*args)
    new(*args).perform
  end

  def initialize(booking, user)
    @booking = booking
    @user = user
  end

  def perform
    Booking.transaction do
      unassign_seats
      booking.user_id = user.id
      booking.status = :cancelled
      booking.save!
    end
  end

  private

  attr_reader :booking, :user

  def unassign_seats
    Trip::UnassignSeats.perform(trip, stop, quantity)
  end
end
