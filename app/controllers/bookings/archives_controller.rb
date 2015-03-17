class Bookings::ArchivesController < ApplicationController
  def index
    bookings = booking_scope.includes(:trip, :client).all
    @booking_presenter = BookingPresenter.new(bookings, params)
  end

  def search
    results = booking_scope.search(params[:q]).result.distinct(true)
    flash[:notice] = "#{view_context.pluralize(results.size, 'Result')} found"
    @booking_presenter = BookingPresenter.new(results, params)
    render partial: 'bookings/booking_listing', locals: { booking_presenter: @booking_presenter }
  end

  def show
    @booking = booking_scope.find(params[:id])
  end

  private
  def booking_scope
    @booking_scope ||= Booking.processed.archived
  end

end