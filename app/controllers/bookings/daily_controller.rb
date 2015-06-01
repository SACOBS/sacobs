class Bookings::DailyController < ApplicationController
  def index
    @bookings = Booking.includes(:stop, :trip, :client, :invoice).processed.for_today
  end

  def print
    @bookings =  Booking.includes(:main, :return_booking).processed.for_today
    render pdf: "daily_bookings_#{Time.zone.now.to_i}.pdf".gsub(' ', '_').downcase,
           disposition: :inline,
           template: 'bookings/_daily_bookings.html.haml',
           layout: 'pdf.html'
  end
end