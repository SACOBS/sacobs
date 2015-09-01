class Bookings::DailyController < ApplicationController
  def index
    @bookings = bookings
  end

  def print
    @bookings = bookings
    render pdf: "daily_bookings_#{Time.current.to_i}.pdf".tr(' ', '_').downcase,
           disposition: :inline,
           template: 'bookings/daily/_bookings',
           layout: 'pdf.html'
  end

  private

  def bookings
    @bookings ||= Booking.processed.where(created_at: Time.current.midnight..Time.current.now.end_of_day)
  end
end
