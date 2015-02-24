module Bookings
  class BuilderController < ApplicationController
    include Wicked::Wizard

    layout 'wizard'

    before_action :set_booking, only: [:index, :show, :update]

    steps :trip_details,
          :return_trip_details,
          :client_details,
          :passenger_details,
          :passenger_charges,
          :billing_info

    def index
      if params[:return] == 'true'
        @stops = ReturnTripSearch.execute(@booking.stop, @booking.quantity, search_params)
        render partial: 'bookings/builder/return_trips', locals: { booking: @booking, stops: @stops }
      else
        @stops = TripSearch.execute(search_params)
        render partial: 'bookings/builder/trips', locals: { booking: @booking, stops: @stops }
      end
      end

    def show
      case step
        when :return_trip_details then skip_step unless @booking.has_return?
      end
      render_wizard
    end

    def update
      @booking_wizard = Booking::Wizard.new(@booking, booking_params)
      @booking_wizard.process(step)
      render_wizard @booking_wizard
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
      params[:q][:trip_date] = Date.civil(params[:q].delete('trip_date(1i)').to_i,
                                          params[:q].delete('trip_date(2i)').to_i,
                                          params[:q].delete('trip_date(3i)').to_i) rescue nil
      params.fetch(:q, {}).delete_if { |_key, value| value.blank? }
    end

    def set_booking
      @booking = Booking.find(params[:booking_id])
    end

    def finish_wizard_path
      booking_path(@booking)
    end

    def booking_params
      client_attributes = { client_attributes: [:id, :_destroy, :title, :name, :surname, :date_of_birth, :high_risk, :cell_no, :home_no, :work_no, :email, :bank, :id_number, :notes, :user_id, address_attributes: [:id, :street_address1, :street_address2, :city, :postal_code, :_destroy]] }
      passengers_attributes = { passengers_attributes: [:id, :name, :surname, :cell_no, :email, :passenger_type_id, charges: []] }
      invoice_attributes = { invoice_attributes: [:id, :billing_date, line_items_attributes: [:id, :description, :amount, :line_item_type]] }
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
