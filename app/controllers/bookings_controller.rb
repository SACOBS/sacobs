class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :destroy]

  def index
    params[:type] ||= 'standby'
    @bookings = Booking.includes(:client,  :trip, stop: :connection)
    case params[:type]
      when 'open'
        @bookings = @bookings.open.page(params[:reserved_page])
      when 'paid'
        @bookings = @bookings.paid.page(params[:paid_page])
      when 'cancelled'
        @bookings = @bookings.cancelled.page(params[:cancelled_page])
      else
        @bookings = @bookings.standby.page(params[:standby_page])
    end

    respond_with(@bookings) if stale?(@bookings)
  end

  def search
    @search = Booking.available.completed.search(params[:q].merge(m: 'or'))
    @results = @search.result.includes(:client,  :trip, stop: :connection).limit(50)
  end

  def create
    @booking = Booking.new(user_id: current_user.id)
    @booking.save(validate: false)
    redirect_to booking_wizard_url(@booking, :trip_details)
  end

  def show
    fresh_when @booking
  end

  def destroy
    @booking.destroy
    respond_with(@booking)
  end

  def cancel
    Booking::Cancel.perform(@booking, current_user)
    redirect_to bookings_url, notice: 'Booking was successfully cancelled.'
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
