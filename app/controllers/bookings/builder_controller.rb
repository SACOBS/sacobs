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
      if @booking.has_return?
        fetch_return_stops
        render partial: 'bookings/builder/return_trips', locals: { booking: @booking, stops: @stops }
      else
        fetch_stops
        render partial: 'bookings/builder/trips', locals: { booking: @booking, stops: @stops }
      end
    end

    def show
      case step
        when :trip_details then
          fetch_stops
        when :return_trip_details then
          @booking.has_return? ? fetch_return_stops : skip_step
      end
      render_wizard
    end

    def update
      case step
        when :trip_details
          fetch_stops
        when :return_trip_details
          fetch_return_stops
        when :passenger_charges
          @booking.sync_return_booking
          build_invoice
        when :billing_info then
          @booking.reserve
      end
      render_wizard @booking
    end


    def cities
      @cities ||= City.all.to_json(only: [:id, :name])
    end
    helper_method :cities

    def clients
      @clients ||= Client.all.to_json(except: [:created_at, :updated_at], methods: :full_name)
    end
    helper_method :clients

    private

    def search_params
      params.fetch(:q, {}).delete_if { |_key, value| value.blank? }
    end

    def fetch_stops
      @stops ||= TripSearch.execute(search_params)
    end

    def fetch_return_stops
      @stops ||= ReturnTripSearch.execute(@booking.stop, @booking.quantity, search_params)
    end

    def finish_wizard_path
      booking_path(@booking)
    end


    def build_invoice
      return_booking = @booking.return_booking
      @booking.invoice = InvoiceBuilder.execute(@booking)
      return_booking.invoice = InvoiceBuilder.execute(return_booking) if return_booking
    end

    def set_booking
      @booking = Booking.find(params[:booking_id])
    end

    def set_attributes
      @booking.assign_attributes(booking_params)
    end

    def booking_params
      client_attributes = { client_attributes: [:id, :_destroy, :title, :name, :surname, :date_of_birth, :high_risk, :cell_no, :home_no, :work_no, :email, :bank, :id_number, :notes, :user_id, address_attributes: [:id, :street_address1, :street_address2, :city, :postal_code, :_destroy]] }
      passengers_attributes = { passengers_attributes: [:id, :name, :surname, :cell_no, :email, :passenger_type_id, charges: []] }
      invoice_attributes = { invoice_attributes: [:id, :billing_date, line_items_attributes: [:id, :description, :amount, :line_item_type]]}
      return_booking_attributes = { return_booking_attributes: [:stop_id, :quantity, :trip_id, :user_id, :id, invoice_attributes] }


      params.fetch(:booking, {}).permit(:trip_id, :status,
                                        :quantity, :client_id,
                                        :has_return, :stop_id,
                                        client_attributes, passengers_attributes,
                                        invoice_attributes, return_booking_attributes
      )
    end
  end
end
