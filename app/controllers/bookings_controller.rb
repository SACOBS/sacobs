class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :confirm, :destroy]

  def index
    @booking_dashboard = BookingDashboard.new(params, view_context)
  end

  def create
    @booking = Booking.create
    redirect_to booking_builder_url(@booking, :trip_details)
  end

  def show
   @decorated_booking = BookingDecorator.decorate(@booking, view_context)
   fresh_when @booking, last_modified: @booking.updated_at
  end

  def destroy
    @booking.destroy
    respond_with(@booking)
  end

  def confirm
    ConfirmBooking.execute(@booking, current_user)
    redirect_to new_booking_payment_detail_url(@booking), notice: 'Booking was successfully confirmed.'
  end

  def cancel
    CancelBooking.execute(@booking, current_user)
    redirect_to bookings_url, notice: 'Booking was succesfully cancelled.'
  end

  private
   def set_booking
    @booking = Booking.find(params[:id])
   end
end