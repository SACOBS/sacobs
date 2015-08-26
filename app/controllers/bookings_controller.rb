class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :cancel, :destroy]

  def index
    type = params[:type] || 'standby'
    case type
      when 'reserved'
        bookings = booking_scope.open.page(params[:reserved_page])
      when 'standby'
        bookings = booking_scope.expired.page(params[:standby_page])
      when 'paid'
        bookings = booking_scope.paid.page(params[:paid_page])
      when 'cancelled'
        bookings = booking_scope.cancelled.page(params[:cancelled_page])
      else
        bookings = booking_scope.none
    end

    @bookings = bookings.select(:id, :status, :created_at, :client_id, :trip_id, :stop_id, :quantity, :expiry_date, :updated_at)

    if request.xhr?
      render partial: 'bookings/bookings', locals: { bookings: @bookings, type: params[:type] }
    else
      render :index
    end
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
    fresh_when @booking
  end

  def destroy
    @booking.destroy
    respond_with(@booking)
  end

  def cancel
    @booking.update(status: :cancelled, user_id: current_user.id)
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
