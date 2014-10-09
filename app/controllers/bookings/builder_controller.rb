module Bookings
  class BuilderController < ApplicationController
    include Wicked::Wizard

    layout 'wizard'

    steps :trip_details,
          :return_trip_details,
          :client_details,
          :passenger_details,
          :passenger_charges,
          :billing_info

    before_action :set_booking, only: [:index, :show, :update]
    before_action :set_attributes, only: :update

    def index
      (params[:return] == 'false') ? fetch_stops : fetch_return_stops
    end

    def show
      case step
      when :trip_details then
        fetch_stops
      when :return_trip_details then
        @booking.has_return? ? fetch_return_stops : skip_step
      when :passenger_details then
        create_passengers
      end
      render_wizard
    end

    def update
      case step
      when :trip_details then
        fetch_stops unless @booking.valid?
      when :passenger_charges
        @booking.sync_return_booking
        build_invoice
      when :billing_info then
        reserve_booking
      end
      render_wizard @booking
    end

    private

    def search_params
      params[:q] ||= {}
      params[:q].delete_if { |_key, value| value.blank? }
    end

    def fetch_stops
      @stops = TripSearch.execute(search_params)
    end

    def fetch_return_stops
      @stops = ReturnTripSearch.execute(@booking.stop, @booking.quantity, search_params)
    end

    def finish_wizard_path
      dashboard_url
    end

    def create_passengers
      passengers = @booking.passengers
      passengers.clear
      @booking.quantity.times { passengers.build(passenger_type: get_passenger_type) }
      @booking.save
    end

    def get_passenger_type
      if @booking.client_is_pensioner?
        passenger_type = PassengerType.find_by(description: :pensioner)
      else
        passenger_type = PassengerType.find_by(description: :standard)
      end
      passenger_type
    end

    def build_invoice
      return_booking = @booking.return_booking
      @booking.invoice = InvoiceBuilder.execute(@booking)
      return_booking.invoice = InvoiceBuilder.execute(return_booking) if return_booking
    end

    def reserve_booking
      ReserveBooking.execute(@booking, current_user)
    end

    def set_booking
      @booking = Booking.find(params[:booking_id])
    end

    def set_attributes
       @booking.assign_attributes(booking_params)
    end

    def booking_params
      BookingParameters.new(params).permit(user: current_user)
    end
  end
end
