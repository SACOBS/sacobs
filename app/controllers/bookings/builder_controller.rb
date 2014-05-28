class Bookings::BuilderController < ApplicationController
  include Wicked::Wizard

  steps  :details, :returns ,:client, :passengers, :billing

  before_action :set_booking, only: [:index, :show, :update]
  before_action :set_attributes, only: :update

  def index
    fetch_stops
  end

  def show
    case step
      when :details then fetch_stops
      when :returns then
        if @booking.has_return?
          @booking.build_return_booking
          fetch_return_stops
        else
          skip_step
        end
      when :client then @booking.build_client
      when :passengers then build_passengers
      when :billing then build_invoice
    end
    render_wizard
  end

  def update
    case step
      when :details then fetch_stops unless @booking.valid?
      when :billing then reserve_booking if @booking.valid?
    end
    render_wizard @booking
  end

  private
    def fetch_stops
      criteria = params[:q]||= {}
      @stops = TripSearch.execute(criteria)
    end

    def fetch_return_stops
      criteria = params[:q]||= {}
      @stops = ReturnTripSearch.execute(@booking.trip, @booking.quantity, criteria)
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

    def build_invoice
      @booking.invoice = InvoiceBuilder.new(@booking).build
      @booking.return_booking.invoice = InvoiceBuilder.new(@booking.return_booking).build if @booking.return_booking
    end


    def set_booking
      @booking = Booking.find(params[:booking_id])
    end

    def set_attributes
      @booking.assign_attributes(booking_params)
    end

    def reserve_booking
      expiry_date = set_booking_expiry_date
      ReserveBooking.execute(@booking, current_user, expiry_date)
    end

    def set_booking_expiry_date
      Time.zone.now.advance hours: settings.booking_expiry_period
    end

    def booking_params
      BookingParameters.new(params).permit(user: current_user)
    end
end
