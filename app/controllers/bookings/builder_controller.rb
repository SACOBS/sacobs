class Bookings::BuilderController < ApplicationController
  include Wicked::Wizard

  steps :client, :passengers, :billing

  before_action :set_booking, only: [ :show, :update]
  before_action :clean_search_query, only: :new

  params_for :booking, :trip_id, :stop_ids, :price, :status, :quantity, :client_id,
             client_attributes: [:id, :_destroy, :name, :surname, :cell_no, :tel_no, :email ,address_attributes: [:id, :street_address1, :street_address2, :city, :postal_code, :_destroy] ],
             passengers_attributes: [:id, :name, :surname, :cell_no, :email ,:passenger_type_id],
             invoice_attributes: [:id, :billing_date, line_items_attributes: [:id,:description, :gross_price,:nett_price, :discount_percentage, :discount_amount]]

  def new
    @stops = Stop.search(params[:q]).result(distinct: true)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.expiry_date = Time.zone.now + 8.hours
    if @booking.save
      redirect_to wizard_path(Wicked::FIRST_STEP, booking_id: @booking)
    else
      flash[:alert] = "#{@booking.errors.full_messages.first}"
      redirect_to new_booking_builder_url
    end
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
    reserve_booking if end_of_wizard?
    @booking.update (booking_params)
    render_wizard @booking
  end

  private
    def finish_wizard_path
      bookings_url
    end

    def build_client
      @booking.build_client
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
      @booking = Booking.find(params[:booking_id])
    end

    def reserve_booking
        assign_seats
        @booking.status = :reserved
    end

    def assign_seats
      SeatingAssigner.new(@booking).assign
    end

    def clean_search_query
      params[:q].delete_if{|k, v| v == 'Select from city' || v == 'Select to city' } if params[:q]
    end

    def end_of_wizard?
      step == :billing
    end
end
