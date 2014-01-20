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
      when :client then build_client
      when :returns then @booking.has_return? ? fetch_stops : skip_step
      when :passengers then build_passengers
      when :billing then build_invoice
    end
    render_wizard
  end

  def update
    @booking.attributes = booking_params
    case step
      when :details then build_return
      when :passengers then update_return_associations
      when :billing then reserve_booking
    end
    render_wizard @booking
  end

  private
    def finish_wizard_path
      bookings_url
    end

    def build_client
      @booking.build_client
    end

    def build_return
      @booking.build_return(quantity: @booking.quantity, user: current_user) if @booking.has_return?
    end

    def update_return_associations
      if @booking.return
        @booking.return.client = @booking.client
        @booking.passengers.each do |passenger|
          @booking.return.passengers << passenger.dup
        end
      end
    end

    def build_passengers
      unless @booking.passengers.any?
        default_passenger_type = PassengerType.find_by(description: :standard)
        @booking.quantity.times { @booking.passengers.create name: @booking.client.name, surname: @booking.client.surname, passenger_type: default_passenger_type  }
      end
    end

    def build_invoice
      @booking.invoice = InvoiceBuilder.new(@booking).build
      @booking.return.invoice = InvoiceBuilder.new(@booking.return).build if @booking.return
    end

    def set_booking
      @booking = Booking.find(params[:booking_id])
    end

    def reserve_booking
        expiry_date = set_booking_expiry_date
        @booking.reserve(expiry_date)
        @booking.return.reserve(expiry_date) if @booking.return
    end

    def clean_search_params
     params[:q].reject!{|k, v| v =~ /Select/ } if params[:q]
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
