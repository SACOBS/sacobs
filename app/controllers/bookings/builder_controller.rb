class Bookings::BuilderController < ApplicationController
  include Wicked::Wizard

  layout 'wizard'

  before_action :set_booking, only: [:show, :update]

  steps :trip_details,
        :return_trip_details,
        :client_details,
        :passenger_details,
        :passenger_charges,
        :billing_info

  def show
    case step
      when :trip_details
        fetch_stops
      when :return_trip_details
        fetch_return_stops
        @booking.build_return_booking
      when :client_details
        @booking.build_client unless @booking.client.present?
      when :passenger_details
        @booking.build_passengers if @booking.passengers.empty?
      when :billing_info
        @booking.build_invoices
    end
    respond_to do |format|
      format.html { render_wizard }
      format.js
    end
  end

  def update
    @booking.reserve if step == :billing_info
    render_wizard @booking
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
    @booking.assign_attributes(booking_params)
  end

  def fetch_stops
    params[:q] ||= {}
    params[:q][:available_seats_gteq] ||= 0
    if @booking.stop.present?
      params[:q][:trip_start_date_gteq] = set_trip_date((@booking.trip.start_date))
      params[:q][:connection_from_city_id_eq] ||= @booking.stop.from_city.id
      params[:q][:connection_to_city_id_eq] ||= @booking.stop.to_city.id
    end
    @stops = Stop.includes(:trip, :connection).search(params[:q]).result.limit(30).order('trips.start_date')
  end

  def fetch_return_stops
    params[:q] ||= {}
    params[:q][:available_seats_gteq] ||= @booking.quantity
    params[:q][:trip_start_date_gteq] = set_trip_date(@booking.trip.start_date)
    params[:q][:connection_to_city_id_eq] ||= @booking.stop.from_city.id
    params[:q][:connection_from_city_id_eq] ||= @booking.stop.to_city.id

    @stops = Stop.includes(:trip, :connection).search(params[:q]).result.limit(30).order('trips.start_date')
  end

  def set_trip_date(default_date = Date.current)
    trip_date = Date.civil(params[:q].delete('trip_start_date_gteq(1i)').to_i, params[:q].delete('trip_start_date_gteq(2i)').to_i, params[:q].delete('trip_start_date_gteq(3i)').to_i) rescue nil
    trip_date = default_date unless trip_date.present? && trip_date >= default_date
    trip_date
  end

  def booking_params
    client_attributes = { client_attributes: [:id, :_destroy, :title, :name, :surname, :date_of_birth, :high_risk, :cell_no, :home_no, :work_no, :email, :bank, :id_number, :notes, :street_address1, :street_address2, :city, :postal_code] }
    passengers_attributes = { passengers_attributes: [:id, :name, :surname, :cell_no, :email, :passenger_type_id, charges: []] }
    invoice_attributes = { invoice_attributes: [:id, :billing_date, line_items_attributes: [:id, :description, :amount, :line_item_type]] }
    return_booking_attributes = { return_booking_attributes: [:stop_id, :quantity, :trip_id, :id, invoice_attributes] }

    permitted = params.fetch(:booking, {}).permit(:trip_id, :status,
                                                  :quantity, :client_id,
                                                  :stop_id,
                                                  client_attributes, passengers_attributes,
                                                  invoice_attributes, return_booking_attributes
                                                 ).merge(user_id: current_user.id)
    permitted.deep_merge!(return_booking_attributes: { user_id: current_user.id }) if permitted.key?(:return_booking_attributes)
    permitted.deep_merge!(client_attributes: { user_id: current_user.id }) if permitted.key?(:client_attributes)
    permitted
  end

  def finish_wizard_path
    booking_path(@booking)
  end
end
