class Bookings::BuilderController < ApplicationController
  include Wicked::Wizard

  layout 'wizard'

  steps  :trip_details, :return_trip_details ,:client_details, :passenger_details, :passenger_charges,:billing_info

  before_action :set_booking, only: [:index, :show, :update]
  before_action :set_attributes, only: :update

  def index
    (params[:return] == 'false') ? fetch_stops : fetch_return_stops
  end

  def show
    case step
      when :trip_details then fetch_stops
      when :return_trip_details
        if @booking.has_return?
          @booking.build_return_booking
          fetch_return_stops
        else
          skip_step
        end
      when :client_details 
      when :passenger_details then build_passengers
    end
    render_wizard
  end

  def update
    case step
      when :trip_details then fetch_stops unless @booking.valid?
      when :passenger_charges
        set_return_associations
        build_invoice
      when :billing_info then reserve_booking if @booking.valid?
    end
    render_wizard @booking
  end

  private
    def search_params
      params[:q] ||= {}
      params[:q].delete_if {|key,value| value.blank? }
    end

    def fetch_stops
      @stops = TripSearch.execute(search_params)
    end

    def fetch_return_stops
      @stops = ReturnTripSearch.execute(@booking.stop, @booking.quantity, search_params)
    end

    def finish_wizard_path
      bookings_url
    end

    def build_passengers
      unless @booking.passengers.any?
        default_passenger_type = PassengerType.find_by(description: :standard)
        @booking.quantity.times { @booking.passengers.create name: @booking.client.name, surname: @booking.client.surname, cell_no: @booking.client.cell_no , email: @booking.client.email  ,passenger_type: default_passenger_type  }
      end
    end

    def set_return_associations
      return unless @booking.has_return?
      return_booking = @booking.return_booking
      return_booking.client = @booking.client
      return_booking.passengers.clear
      @booking.passengers.each {|p| return_booking.passengers << p.dup }
      return_booking.save!
    end

    def build_invoice
      @booking.invoice = InvoiceBuilder.new(@booking).build
      @booking.return_booking.invoice = InvoiceBuilder.new(@booking.return_booking).build if @booking.return_booking
    end

    def reserve_booking
      expiry_date = set_booking_expiry_date
      ReserveBooking.execute(@booking, current_user, expiry_date)
    end

    def set_booking_expiry_date
      Time.zone.now.advance hours: settings.booking_expiry_period
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
