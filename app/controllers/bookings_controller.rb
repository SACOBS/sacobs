class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :destroy]

  def index
    type = params[:type] || 'standby'
    case type
      when 'reserved'
        @bookings = Booking.includes(:client,  :trip, stop: :connection).open.order(:created_at).page(params[:reserved_page])
      when 'standby'
        @bookings = Booking.includes(:client,  :trip, stop: :connection).expired.order(:created_at).page(params[:standby_page])
      when 'paid'
        @bookings = Booking.includes(:client,  :trip, stop: :connection).paid.order(:created_at).page(params[:paid_page])
      when 'cancelled'
        @bookings = Booking.includes(:client,  :trip, stop: :connection).cancelled.order(:created_at).page(params[:cancelled_page])
      else
        @bookings = Booking.none
    end

    respond_with(@bookings) if stale?(@bookings)
  end

  def search
    @search = Booking.processed.search(params[:q].merge(m: 'or'))
    @results = @search.result.includes(:client,  :trip, stop: :connection).order(:created_at).limit(50)
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
