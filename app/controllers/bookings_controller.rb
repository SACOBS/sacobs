# == Schema Information
#
# Table name: bookings
#
#  id                :integer          not null, primary key
#  trip_id           :integer
#  price             :decimal(, )      default(0.0)
#  status            :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#  quantity          :integer          default(0)
#  expiry_date       :datetime
#  client_id         :integer
#  user_id           :integer
#  reference_no      :string(255)
#  main_id           :integer
#  stop_id           :integer
#  sequence_id       :integer
#  archived          :boolean          default(FALSE)
#  archived_at       :datetime
#  payment_detail_id :integer
#
# Indexes
#
#  index_bookings_on_archived   (archived)
#  index_bookings_on_client_id  (client_id)
#  index_bookings_on_main_id    (main_id)
#  index_bookings_on_stop_id    (stop_id)
#  index_bookings_on_trip_id    (trip_id)
#

class BookingsController < ApplicationController
  def index
    params[:type] ||= "standby"
    bookings = case params[:type]
               when "open"
                 Booking.includes(:client, :trip, stop: :connection).available.open.page(params[:reserved_page])
               when "paid"
                 Booking.includes(:client, :trip, stop: :connection).available.paid.page(params[:paid_page])
               when "cancelled"
                 Booking.includes(:client, :trip, stop: :connection).available.cancelled.page(params[:cancelled_page])
               else
                 Booking.includes(:client, :trip, stop: :connection).available.standby.page(params[:standby_page])
    end

    if stale?(bookings)
      @presenter = Bookings::IndexPresenter.new(bookings)
      render :index
    end
  end

  def search
    @search = Booking.available.completed.search(params[:q].merge(m: "or"))
    @results = @search.result.includes(:client, :trip, stop: :connection).limit(50)
  end

  def create
    @booking = Booking.create(user_id: current_user.id)
    redirect_to booking_wizard_url(@booking, :trip_details)
  end

  def show
    @booking = Booking.includes(:stop, :trip, :client, :invoice, passengers: :passenger_type).find(params[:id])
    fresh_when @booking
  end

  def destroy
    @booking = Booking.destroy(params[:id])
    respond_with(@booking)
  end

  def cancel
    @booking = Booking.find(params[:id])
    Booking::Cancel.perform(@booking, current_user)
    redirect_to bookings_url, notice: "Booking was successfully cancelled."
  end
end
