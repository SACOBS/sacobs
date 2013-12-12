class Bookings::BuilderController < ApplicationController
  include Wicked::Wizard

  steps :return, :client, :passengers, :billing

  before_action :set_booking, only: [ :show, :update]

  params_for :booking, :trip_id, :price, :status, :quantity, :client_id,
             client_attributes: [:id, :_destroy, :name, :surname, :cell_no, :tel_no, :email ,address_attributes: [:id, :street_address1, :street_address2, :city, :postal_code, :_destroy] ],
             passengers_attributes: [:id, :name, :surname, :cell_no, :email ,:passenger_type_id],
             invoice_attributes: [:id, :billing_date, line_items_attributes: [:id,:description, :gross_price,:nett_price, :discount_percentage, :discount_amount]]

  def new
    @trips = Trip.all
  end

  def create
    trip = find_trip
    if trip.seats_available?(params[:trip][:from], params[:trip][:to], params[:trip][:seats].to_i)
      booking = trip.bookings.create!(quantity: params[:trip][:seats].to_i, stops: trip.available_stops(params[:trip][:from], params[:trip][:to]), expiry_date: calculate_expiry_date, return: false)
      next_wizard_step = params[:trip][:return] ? :return : :client
      redirect_to wizard_path(next_wizard_step, booking_id: booking)
    else
      redirect_to new_booking_builder_path(booking_id: :start), alert: 'There are no available seats on the selected trip'
    end
  end

  def show
    case step
      when :return
        @trips = Trip.starting @booking.trip.to
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
    case step
      when :return
        build_return
      when :billing
        reserve_booking(@booking)
        reserve_booking(@booking.return_booking)
    end
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

    def calculate_expiry_date
      Time.zone.now + (settings['booking_expiry_period'].to_i).hours
    end

    def build_invoice
      invoice = InvoiceBuilder.new(@booking).build
      invoice.save!
    end

    def set_booking
      @booking =  Booking.find(params[:booking_id])
    end

    def build_return
      trip = find_trip
      @booking.return_booking = trip.bookings.build(quantity: @booking.quantity, stops: trip.available_stops(params[:trip][:from], params[:trip][:to]), expiry_date: @booking.expiry_date, return: true) if trip.seats_available?(params[:trip][:from], params[:trip][:to], params[:trip][:seats].to_i)
    end

    def find_trip
      Trip.find(params[:trip][:id])
    end

    def reserve_booking(booking)
        booking.stops.each { |s| s.decrement(:available_seats, booking.quantity) }
        booking.status = 'reserved'
    end
end
