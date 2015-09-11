class Booking::Confirm
  def self.perform(*args)
    new(*args).perform
  end

  def initialize(booking, user)
    @booking = booking.main || booking
    @return_booking =  @booking.return_booking
    @user = user
  end

  def perform
    Booking.transaction do
      [booking, return_booking].compact.each do |booking|
        booking.price = booking.invoice.total
        booking.status = :paid
        booking.user_id = user.id
        booking.save!
      end
    end
  end

  private
  attr_reader :booking, :return_booking, :user, :payment_details
end