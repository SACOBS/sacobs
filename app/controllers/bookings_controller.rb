class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :mark_as_paid, :destroy]

  def index
    @q = Booking.includes(:trip, :client, :stops, :passengers).search(params[:q])
    @bookings = @q.result(distinct: true).decorate
  end

  def show
    @booking = @booking.decorate
  end

  def destroy
    SeatingService.new(@booking.trip, @booking.stop.connection).increment_seating(@booking.quantity)
    @booking.destroy
    respond_with(@booking)
  end

  def mark_as_paid
    @booking.mark_as_paid
    respond_with(@booking,location: bookings_url, notice: 'Booking was succesfully marked as paid')
  end

  def cancel
    SeatingService.new(@booking.trip, @booking.stop.connection).increment_seating(@booking.quantity)
    @booking.cancel
    respond_with(@booking, location: bookings_url, notice: 'Booking was succesfully cancelled')
  end

  private
  def set_booking
    @booking = Booking.includes(:trip, :client, :stops, :passengers).find(params[:id])
  end

end