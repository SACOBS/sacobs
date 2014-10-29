class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :confirm, :destroy]

  def index
    bookings = booking_scope.all
    @booking_presenter = BookingPresenter.new(bookings, params)
  end

  def daily
    @bookings = booking_scope.for_today
  end

  def print_daily
    @bookings = booking_scope.for_today
    render pdf: "daily_bookings_#{Time.zone.now.to_i}.pdf".gsub(' ', '_').downcase,
           disposition: :inline,
           template: 'bookings/_daily_bookings.html.haml',
           layout: 'pdf.html'
  end

  def search
    results = booking_scope.search(params[:q]).result.distinct(true)
    flash[:notice] = "#{view_context.pluralize(results.size, 'Result')} found"
    @booking_presenter = BookingPresenter.new(results, params)
    render partial: 'bookings/booking_listing', locals: { booking_presenter: @booking_presenter }
  end

  def create
    @booking = Booking.create
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
    CancelBooking.execute(@booking, current_user)
    redirect_to bookings_url, notice: 'Booking was successfully cancelled.'
  end

  private

  def booking_scope
    @booking_scope ||= Booking.includes(:trip, :stop, :client).not_in_process.active
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
