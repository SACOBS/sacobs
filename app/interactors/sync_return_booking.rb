class SyncReturnBooking
  include Interactor

  before do
    context.return_booking = context.booking.return_booking
  end

  def call
   Booking.transaction do
     set_client
     set_passengers
     context.fail! and raise ActiveRecord::Rollback unless context.return_booking.save
   end
  end

  private
   def set_client
     context.return_booking.client = context.booking.client
   end

   def set_passengers
     context.return_booking.passengers.clear
     context.booking.passengers.each { |passenger| context.return_booking.passengers << passenger.dup }
   end
end
