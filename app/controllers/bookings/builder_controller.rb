class Bookings::BuilderController < ApplicationController
  include Wicked::Wizard

  steps  :details, :returns ,:client, :passengers, :billing

  before_action :set_booking, only: [:index, :show, :update]

  def index
    @stops = fetch_stops
  end

  def show
    case step
    when :details then fetch_stops
    when :client then @booking.build_client
      when :returns
        if @booking.has_return?
          @booking.build_return_booking(quantity: @booking.quantity, user: current_user)
          fetch_stops
        else
          skip_step
        end
    when :passengers then build_passengers
    when :billing then build_invoice
    end
    render_wizard
  end

  def update
    case step
      when :details then fetch_stops unless @booking.valid?
      when :client then @booking.return_booking.client = @booking.client if @booking.return_booking && @booking.valid?
      when :passengers then @booking.passengers.each { |p| @booking.return_booking.passengers << p.dup } if @booking.return_booking && @booking.valid?
      when :billing then reserve_booking if @booking.valid?
    end
    persist

    render_wizard @booking
  end

  private
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

    def persist
      if @booking.return_booking
        Booking.transaction do
          raise ActiveRecord::Rollback unless @booking.save && @booking.return_booking.save
        end
      else
        @booking.save
      end
    end

    def set_booking
      @booking = Booking.find(params[:booking_id])
      @booking.assign_attributes(booking_params)
    end

    def reserve_booking
      expiry_date = set_booking_expiry_date
      ReserveBooking.new(@booking, current_user, expiry_date).reserve
    end

    def fetch_stops
      criteria = params[:q] ||= {}
      @stops = JourneySearch.new(@booking, criteria).results
    end

    def set_booking_expiry_date
      Time.zone.now.advance hours: settings.booking_expiry_period
    end

    def booking_params
      BookingParameters.new(params).permit(user: current_user)
    end
end
