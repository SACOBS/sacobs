class BookingsController < ApplicationController
  before_action :set_booking

  private
  def set_booking
    @booking = Booking.find(params[:id])
  end

end