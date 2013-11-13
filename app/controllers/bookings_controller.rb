class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :mark_as_paid, :destroy]

  def index
   @bookings = Booking.includes(:trip, :client, :stops, :passengers)
  end

  def show
    @booking = @booking.decorate
  end

  def destroy
    @booking.destroy
    respond_with(@booking)
  end

  def mark_as_paid
    @booking.mark_as_paid
    respond_with(@booking,location: bookings_url, notice: 'Booking was succesfully marked as paid')
  end

  def cancel
    @booking.cancel
    respond_with(@booking, location: bookings_url, notice: 'Booking was succesfully cancelled')
  end

  private
  def set_booking
    @booking = Booking.includes(:trip, :client, :stops, :passengers).find(params[:id])
  end

end