class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :destroy]

  def index
    case params[:type]
      when 'reserved'
        @bookings = booking_scope.reserved.open.page(params[:reserved_page])
      when 'standby'
        @bookings = booking_scope.reserved.expired.page(params[:standby_page])
      when 'paid'
        @bookings = booking_scope.paid.page(params[:paid_page])
      when 'cancelled'
        @bookings =  booking_scope.cancelled.page(params[:cancelled_page])
      else
        @bookings = booking_scope.none
    end
  end

  def daily
    @bookings = Booking.includes(:stop, :trip, :client, :invoice).processed.for_today
  end

  def print_daily
    @bookings =  Booking.includes(:main, :return_booking).processed.for_today
    render pdf: "daily_bookings_#{Time.zone.now.to_i}.pdf".gsub(' ', '_').downcase,
           disposition: :inline,
           template: 'bookings/_daily_bookings.html.haml',
           layout: 'pdf.html'
  end

  def search
    @search = booking_scope.search(params[:q])
    @results = @search.result.limit(50)
  end

  def create
    @booking = Booking.create(quantity: 1)
    redirect_to booking_builder_url(@booking, :trip_details)
  end

  def show
    fresh_when @booking, last_modified: @booking.updated_at
  end

  def destroy
    @booking.destroy
    respond_with(@booking)
  end

  def cancel
    @booking.user = current_user
    @booking.cancel
    if @booking.cancelled?
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
