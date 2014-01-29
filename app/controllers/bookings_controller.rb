class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :confirm, :destroy]
  decorates_assigned :bookings
  decorates_assigned :booking

  def index
    @q = Booking.not_in_process.active.search(params[:q])
    @bookings = @q.result(distinct: true)
  end

  def create
    @booking = Booking.create
    redirect_to booking_builder_url(@booking, :details)
  end

  def show
    fresh_when @booking, last_modified: @booking.updated_at
  end

  def destroy
    @booking.destroy
    respond_with(@booking)
  end

  def confirm
    @booking.update(status: :paid, user: current_user)
    respond_with(@booking,location: new_booking_payment_detail_url(@booking), notice: 'Booking was succesfully confirmed')
  end

  def cancel
    unassign_seats
    @booking.update(status: :cancelled, user: current_user)
    respond_with(@booking, location: bookings_url, notice: 'Booking was succesfully cancelled')
  end

  private
   def set_booking
    @booking = Booking.includes(:trip, :client, :stop, :passengers).find(params[:id])
   end

   def unassign_seats
     SeatingAssigner.new(@booking).unassign
   end
end