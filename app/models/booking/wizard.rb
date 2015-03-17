class Booking::Wizard
  module Helpers
    extend ActionView::Helpers::NumberHelper
  end

  def initialize(booking, params = {})
    @booking = booking
    @booking.assign_attributes(params)
  end

  def process(step)
    Booking.transaction do
      case step
        when :trip_details
          build_return_booking
        when :client_details
          build_passengers
        when :passenger_charges
          sync_return
          build_invoices
        when :billing_info
          reserve_bookings
      end
      fail ActiveRecord::Rollback unless @booking.save
    end
  end

  def save
    @booking.valid?
  end

  private

  def build_return_booking
    if @booking.has_return?
      @booking.build_return_booking
    else
      @booking.return_booking.destroy if @booking.return_booking.present?
    end
  end

  def build_passengers
    @booking.passengers.clear
    @booking.quantity.times do
      @booking.passengers.build(name: @booking.client_name,
                                surname: @booking.client_surname,
                                cell_no: @booking.client_cell_no,
                                email: @booking.client_email)
    end
  end

  def build_invoices
    [@booking, @booking.return_booking].compact.each do |booking|
      price = booking.stop.cost
      invoice = booking.create_invoice
      booking.passengers.each do |passenger|
        # Ticket price
        invoice.line_items.debit.create(description: "#{passenger.full_name} ticket", amount: price)

        # Additional Charges
        total_charges = 0
        passenger.charges.each do |charge|
          description = "#{charge.description} charge - #{Helpers.number_to_percentage(charge.percentage * 100, precision: 0)}".capitalize
          amount = Calculations.roundup(price * charge.percentage)
          total_charges += amount
          invoice.line_items.debit.create(description: description, amount: amount)
        end

        # Discount
        discount = SeasonalDiscount.active_in_period(Date.today).where(passenger_type: passenger.passenger_type).take || passenger.discount
        description = "#{discount.description} discount - #{Helpers.number_to_percentage(discount.percentage * 100, precision: 0)}".capitalize
        amount = Calculations.roundup((price + total_charges) * discount.percentage)
        invoice.line_items.credit.create(description: description, amount: amount)
      end
    end
  end

  def sync_return
    return unless @booking.has_return?
    @booking.return_booking.client = @booking.client
    @booking.return_booking.passengers = @booking.passengers.map(&:dup)
  end

  def reserve_bookings
    [@booking, @booking.return_booking].compact.each(&:reserve)
  end
end
