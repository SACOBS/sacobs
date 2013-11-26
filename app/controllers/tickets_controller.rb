class TicketsController < ApplicationController
  before_action :set_booking

  def show

  end

  def print
  end

  private
   def set_booking
     @booking = Booking.find(params[:id]).decorate
   end
end
