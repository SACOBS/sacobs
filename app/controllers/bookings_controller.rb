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
    unassign_seats
    @booking.destroy
    respond_with(@booking)
  end

  def mark_as_paid
    @booking.update(status: :paid)
    respond_with(@booking,location: bookings_url, notice: 'Booking was succesfully marked as paid')
  end

  def cancel
    unassign_seats
    @booking.update(status: :cancelled)
    respond_with(@booking, location: bookings_url, notice: 'Booking was succesfully cancelled')
  end

  private
   def set_booking
    @booking = Booking.includes(:trip, :client, :stops, :passengers).find(params[:id])
   end

   def unassign_seats
     SeatingAssigner.new(@booking).unassign
   end

end