class Bookings::ArchivesController < ApplicationController
  def index
    @bookings = booking_scope.page(params[:page])
  end

  def search
    results = booking_scope.search(params[:q]).result.page(params[:page])
    flash[:notice] = "#{view_context.pluralize(results.total_count, 'Result')} found"
    render partial: 'bookings/archives/bookings', locals: { bookings: results }
  end

  def show
    @booking = Booking.archived.find(params[:id])
  end

  private
  def booking_scope
    @booking_scope ||= Booking.archived.processed.includes(:stop, :client)
  end

end