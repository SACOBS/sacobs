class Bookings::DailyController < ApplicationController
  def index
    @bookings = bookings
  end

  def print
    @bookings =  bookings
    render pdf: "daily_bookings_#{Time.zone.now.to_i}.pdf".gsub(' ', '_').downcase,
           disposition: :inline,
           template: 'bookings/_daily_bookings.html.haml',
           layout: 'pdf.html'
  end

  private
  def bookings
    @bookings ||= Booking.processed.where(created_at: Time.now.midnight..Time.now.end_of_day)
  end
end