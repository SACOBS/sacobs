class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :destroy]

  def index
    type = params[:type] || 'standby'
    case type
      when 'reserved'
        @bookings = booking_scope.open.page(params[:reserved_page])
      when 'standby'
        @bookings = booking_scope.expired.page(params[:standby_page])
      when 'paid'
        @bookings = booking_scope.paid.page(params[:paid_page])
      when 'cancelled'
        @bookings = booking_scope.cancelled.page(params[:cancelled_page])
      else
        @bookings = booking_scope.none
    end

    respond_with(@bookings) if stale?(@bookings)
  end

  def search
    @search = booking_scope.search(params[:q])
    @results = @search.result.limit(50)
  end

  def create
    @booking = Booking.create
    redirect_to booking_builder_url(@booking, :trip_details)
  end

  def show
    fresh_when @booking
  end

  def destroy
    @booking.destroy
    respond_with(@booking)
  end

  def cancel
    @booking.user_id = current_user.id
    if @booking.cancel
      redirect_to bookings_url, notice: 'Booking was successfully cancelled.'
    else
      redirect_to bookings_url, alert: 'Booking could not be cancelled.'
    end
  end

  private

  def booking_scope
    @booking_scope ||= Booking.processed.includes(:stop, :client, :trip).order(:created_at)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
