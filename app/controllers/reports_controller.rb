class ReportsController < ApplicationController

  def index;end

  def bookings_per_status
   render json: Booking.group(:status).count
  end

  def bookings_per_user
   render json: Booking.joins(:user).group('users.name').count
  end

  def income_per_month
    render json: Booking.paid.group_by_month(:created_at, format: '%b').sum(:price)
  end
end