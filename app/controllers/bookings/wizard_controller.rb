module Bookings
  class WizardController < ApplicationController
    include Wicked::Wizard

    layout 'wizard'

    before_action :set_booking
    before_action :set_stops, only: :show, if: proc { %i(trip_details return_trip_details).include?(step) }
    before_action :wizard_completed, only: :show

    steps :trip_details,
          :return_trip_details,
          :client_details,
          :passenger_details,
          :passenger_charges,
          :billing_info

    def show
      case step
      when :return_trip_details
        @booking.build_return_booking(quantity: @booking.quantity)
      when :client_details
        @booking.build_client unless @booking.client.present?
      when :billing_info
        Booking::BuildInvoice.perform(@booking)
      end
      respond_to do |format|
        format.html { render_wizard }
        format.js
      end
    end

    def update
      @booking.update(booking_params)

      case step
      when :trip_details
        @stops = [@booking.stop]
      when :return_trip_details
        @stops = [@booking.return_booking.stop]
      when :billing_info
        Booking::Reserve.perform(@booking, @settings)
      end
      respond_to { |format| format.html { render_wizard @booking } }
    end

    private

    def set_booking
      @booking = Booking.find(params[:booking_id])
    end

    def set_stops
      @stops = Stop.includes(:trip, :connection).
               merge(Trip.available).
               search(search_params).result.limit(30).order('trips.start_date')
    end

    def search_params
      params.fetch(:q, {}).reverse_merge(default_search_params)
    end

    def default_search_params
      {
        available_seats_gteq:       @booking.quantity,
        trip_start_date_eq:         start_date,
        connection_from_city_id_eq: from_city,
        connection_to_city_id_eq:   to_city
      }
    end

    def start_date
      @booking.trip&.start_date || Date.current
    end

    def from_city
      step == :return_trip_details ? @booking.connection.to_city.id : @booking.connection&.from_city&.id
    end

    def to_city
      step == :return_trip_details ? @booking.connection.from_city.id : @booking.connection&.to_city&.id
    end

    def booking_params
      params.require(:booking).permit(
        booking_attributes,
        client_attributes:         client_attributes,
        passengers_attributes:     passengers_attributes,
        invoice_attributes:        invoice_attributes,
        return_booking_attributes: return_booking_attributes
      )
    end

    def booking_attributes
      %i(trip_id status quantity client_id stop_id)
    end

    def return_booking_attributes
      [
        :stop_id, :quantity,
        :trip_id, :id,
        invoice_attributes: invoice_attributes
      ]
    end

    def invoice_attributes
      [
        :id, :billing_date,
        line_items_attributes: %i(id description amount line_item_type)
      ]
    end

    def client_attributes
      %i(
        id title name surname
        date_of_birth high_risk cell_no home_no work_no email
        bank id_number notes
        street_address1 street_address2 city postal_code
      )
    end

    def passengers_attributes
      [
        :id, :name, :surname,
        :cell_no, :email,
        :passenger_type_id, charges: []
      ]
    end

    def finish_wizard_path
      booking_url(@booking)
    end

    def wizard_completed
      redirect_to @booking if @booking.reserved?
    end
  end
end
