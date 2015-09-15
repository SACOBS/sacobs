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
        @booking.build_client unless @booking.client.present?
      when :billing_info
        Booking::BuildInvoice.perform(@booking)
    end
    respond_to do |format|
      format.html { render_wizard }
      format.js
    end
  end

  def update
    @booking.update(booking_params)
    Booking::Reserve.perform(@booking, @settings) if step == :billing_info
    render_wizard @booking
  end

  private

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def set_stops
    if step == :trip_details
      params[:q] ||= {}
      params[:q][:available_seats_gt] = 0
      if @booking.stop.present?
        params[:q][:trip_start_date_gteq] = @booking.trip.start_date
        params[:q][:connection_from_city_id_eq] = @booking.connection.from.city_id
        params[:q][:connection_to_city_id_eq] = @booking.connection.to.city_id
      end
      @stops = Stop.includes(:trip, :connection).search(params[:q]).result.limit(30).order('trips.start_date')
    end
  end

  def set_return_stops
    if step == :return_trip_details
      params[:q] ||= {}
      params[:q][:available_seats_gteq] = @booking.quantity
      params[:q][:trip_start_date_gteq] = @booking.trip.start_date
      params[:q][:connection_from_city_id_eq] = @booking.connection.to.city_id
      params[:q][:connection_to_city_id_eq] = @booking.connection.from.city_id
      @stops = Stop.includes(:trip, :connection).search(params[:q]).result.limit(30).order('trips.start_date')
    end
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
