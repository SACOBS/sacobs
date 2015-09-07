class Bookings::WizardController < ApplicationController
  include Wicked::Wizard

  layout 'wizard'

  before_action :set_booking, only: [:show, :update]
  before_action :set_stops, :set_return_stops, :wizard_completed, only: :show

  steps :trip_details,
        :return_trip_details,
        :client_details,
        :passenger_details,
        :passenger_charges,
        :billing_info

  def show
    case step
      when :return_trip_details
        @booking.build_return_booking(quantity: @booking.quantity)
      when :client_details
        @booking.build_client unless @booking.client
      when :passenger_details
        @booking.build_passengers if @booking.passengers.empty?
      when :billing_info
        @booking.calculate_costs
        @booking.return_booking.calculate_costs if @booking.return_booking
    end
    respond_to do |format|
      format.html { render_wizard }
      format.js
    end
  end

  def update
    @booking.assign_attributes(booking_params)
    case step
      when :trip_details
        @stops = [@booking.stop]
      when :return_trip_details
        @stops = [@booking.return_booking.stop]
      when :client_details
        @booking.passengers.clear if @booking.client_id_changed?
      when :passenger_charges
        if @booking.return_booking.present?
          @booking.return_booking.client = @booking.client
          @booking.return_booking.passengers = @booking.passengers.map(&:dup)
        end
      when :billing_info
        ReserveBooking.new(@booking, @settings).perform
    end
    render_wizard @booking
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def set_stops
    if step == :trip_details
      params[:q] ||= {}
      params[:q][:available_seats_gteq] = @booking.quantity
      params[:q][:trip_start_date_gteq] = Date.civil(params[:q].delete('trip_start_date_gteq(1i)').to_i, params[:q].delete('trip_start_date_gteq(2i)').to_i, params[:q].delete('trip_start_date_gteq(3i)').to_i) rescue Date.current
      if @booking.stop.present?
        params[:q][:trip_start_date_gteq] = @booking.trip.start_date
        params[:q][:connection_from_city_id_eq] = @booking.stop.connection.from.city_id
        params[:q][:connection_to_city_id_eq] = @booking.stop.connection.to.city_id
      end
    end
    @stops = Stop.includes(:trip, :connection).search(params[:q]).result.limit(30).order('trips.start_date')
  end

  def set_return_stops
    if step == :return_trip_details
      params[:q] ||= {}
      params[:q][:available_seats_gteq] = @booking.quantity
      params[:q][:trip_start_date_gteq] = @booking.trip.start_date
      params[:q][:connection_from_city_id_eq] = @booking.stop.connection.to.city_id
      params[:q][:connection_to_city_id_eq] = @booking.stop.connection.from.city_id
      if @booking.return_booking.present? && @booking.return_booking.stop.present?
        params[:q][:trip_start_date_gteq] = @booking.return_booking.trip.start_date
        params[:q][:connection_from_city_id_eq] = @booking.return_booking.stop.connection.from.city_id
        params[:q][:connection_to_city_id_eq] = @booking.return_booking.stop.connection.to.city_id
      end
    end
    @stops = Stop.includes(:trip, :connection).search(params[:q]).result.limit(30).order('trips.start_date')
  end

  def booking_params
    client_attributes = { client_attributes: [:id, :title, :name, :surname, :date_of_birth, :high_risk, :cell_no, :home_no, :work_no, :email, :bank, :id_number, :notes, :street_address1, :street_address2, :city, :postal_code] }
    passengers_attributes = { passengers_attributes: [:id, :name, :surname, :cell_no, :email, :passenger_type_id, charges: []] }
    invoice_attributes = { invoice_attributes: [:id, :billing_date, line_items_attributes: [:id, :description, :amount, :line_item_type]] }
    return_booking_attributes = { return_booking_attributes: [:stop_id, :quantity, :trip_id, :id, invoice_attributes] }

    params.require(:booking).permit(:trip_id, :status, :quantity, :client_id, :stop_id, client_attributes, passengers_attributes, invoice_attributes, return_booking_attributes).tap do |whitelist|
      whitelist.merge!(user_id: current_user.id)
      whitelist[:client_attributes].merge!(user_id: current_user.id) if whitelist.key?(:client_attributes)
      whitelist[:return_booking_attributes].merge!(user_id: current_user.id) if whitelist.key?(:return_booking_attributes)
    end
  end

  def finish_wizard_path
    booking_url(@booking)
  end

  private

  def wizard_completed
    redirect_to @booking if @booking.reserved?
  end
end
