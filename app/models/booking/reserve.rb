class Booking::Reserve



  delegate :return_booking, to: :booking

  def self.perform(*args)
    new(*args).perform
  end


  def initialize(booking, settings)
    @booking = booking
    @settings = settings
  end

  def perform
    Booking.transaction do
      [booking, return_booking].compact.each do |booking|
        assign_seats(booking.trip, booking.stop, booking.quantity)
        booking.expiry_date = expiry_date
        booking.status = :reserved
        booking.save!
      end
    end
  end

  private
  attr_reader :booking, :settings

  def assign_seats(trip, stop, qty)
    Trip::AssignSeats.perform(trip, stop, qty)
  end

  def generate_reference(booking)
    "#{SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')[0..4].upcase.concat('%03d' % booking.sequence_id)}"
  end

  def expiry_date
   @expiry_date ||= settings.booking_expiry_period.hours.from_now
  end
end
