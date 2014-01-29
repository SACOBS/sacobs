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
    if ConfirmBooking.new(@booking, current_user).confirm
      redirect_to new_booking_payment_detail_url(@booking), notice: 'Booking was successfully confirmed.'
    else
      redirect_to bookings_url, alert: 'Booking could not be confirmed.'
    end
  end

  def cancel
    if CancelBooking.new(@booking, current_user).cancel
      flash[:notice] = 'Booking was succesfully cancelled.'
    else
      flash[:alert] = 'Booking could not be cancelled.'
    end
    redirect_to bookings_url
  end

  private
   def set_booking
    @booking = Booking.includes(:trip, :client, :stop, :passengers).find(params[:id])
   end

   def unassign_seats
     SeatingAssigner.new(@booking).unassign
   end
end