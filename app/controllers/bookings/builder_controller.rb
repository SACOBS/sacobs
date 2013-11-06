class Bookings::BuilderController < ApplicationController
  include Wicked::Wizard

  steps :client, :passengers, :billing

  before_action :set_booking, only: [:destroy, :show, :update]

  params_for :booking, :trip_id, :price, :status, :quantity, :client_id,
             client_attributes: [:id, :_destroy, :name, :surname, :cell_no, :tel_no, :email ,address_attributes: [:id, :street_address1, :street_address2, :city, :postal_code, :_destroy] ],
             passengers_attributes: [:id, :name, :surname, :passenger_type_id],
             invoice_attributes: [:id, :billing_date, line_items_attributes: [:id,:description, :amount, :discount_percentage, :discount_amount]]

#  amount              :decimal(8, 2)
#  discount_percentage :integer
#  discount_amount     :decimal(8, 2)
#  invoice_id


#  trip_id     :integer
#  price       :decimal(, )
#  status      :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  quantity    :integer          default(0)
#  expiry_date :datetime
#  client_id   :integer




  def new
    @trips = Trip.all
  end

  def create
    trip = Trip.find(params[:trip][:id])
    stops = trip.available_stops(params[:trip][:from], params[:trip][:to])
    if stops.empty? || stops.any? { |s| s.available_seats <  params[:trip][:seats].to_i }
      redirect_to new_booking_url, alert: 'There are no available seats on the selected trip'
    else
      booking = trip.bookings.create!(quantity: params[:trip][:seats].to_i)
      booking.stops << stops
      redirect_to wizard_path(Wicked::FIRST_STEP, booking_id: booking)
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
    @booking.update(booking_params)
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
      invoice.save
    end

    def set_booking
      @booking =  Booking.find(params[:booking_id])
    end
end
