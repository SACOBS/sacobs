class Bookings::BuilderController < ApplicationController
  include Wicked::Wizard

  steps :client, :passengers, :billing

  before_action :set_booking, only: [ :show, :update]

  params_for :booking, :trip_id, :price, :status, :quantity, :client_id,
             client_attributes: [:id, :_destroy, :name, :surname, :cell_no, :tel_no, :email ,address_attributes: [:id, :street_address1, :street_address2, :city, :postal_code, :_destroy] ],
             passengers_attributes: [:id, :name, :surname, :cell_no, :email ,:passenger_type_id],
             invoice_attributes: [:id, :billing_date, line_items_attributes: [:id,:description, :gross_price,:nett_price, :discount_percentage, :discount_amount]]

  def new
    @trips = Trip.all.decorate
  end

  def create
    booking_service = BookingService.new(params[:trip])
    if booking_service.seats_available?
      booking =  booking_service.create_booking!
      redirect_to wizard_path(Wicked::FIRST_STEP, booking_id: booking)
    else
      redirect_to new_booking_builder_path(booking_id: :start), alert: "There are only #{booking_service.available_seats} available seats on the selected trip"
    end
  end

  def find_trips
    start_date = Date.parse(params[:trip_search][:date])
    route = Route.find(params[:trip_search][:route])
    @trips = Trip.where(start_date: start_date, route: route )
  end

  def show
    case step
      when :client
        build_client
      when :passengers
        build_passengers
      when :billing
        build_invoice
    end
    render_wizard
  end

  def update
    reserve_booking(@booking) if step == :billing
    @booking.update (booking_params)
    render_wizard @booking
  end

  private
    def finish_wizard_path
      bookings_url
    end

    def build_client
      @booking.build_client { |client| client.build_address }
    end

    def build_passengers
      unless @booking.passengers.any?
        default_passenger_type = PassengerType.find_by(description: :standard)
        @booking.quantity.times { @booking.passengers.create name: @booking.client.name, surname: @booking.client.surname, passenger_type: default_passenger_type  }
      end
    end


    def build_invoice
      invoice = InvoiceBuilder.new(@booking).build
      invoice.save!
    end

    def set_booking
      @booking =  Booking.find(params[:booking_id])
    end

    def reserve_booking(booking)
        trip = booking.trip
        connection = booking.stops.first.connection
        AssignSeating.new(trip, connection).decrement(booking.quantity)
        booking.status = :reserved
        booking.reference_no = generate_ref_no(booking)
    end

    def generate_ref_no(booking)
      "#{booking.created_at.strftime('%Y%m%d')} #{booking.client.full_name} #{SecureRandom.hex(2)}".gsub(/\s+/, "")
    end
end
