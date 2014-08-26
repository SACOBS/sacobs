class InvoiceBuilder
  module Helpers
    extend ActionView::Helpers::NumberHelper
  end

  def initialize(booking)
    @booking = booking
    @invoice = Invoice.new
  end

  def build
    @booking.passengers.each do |p|
      build_ticket_cost(p)
      build_additional_charges(p)
      build_passenger_discount(p)
    end
    build_client_credit(@booking.client)
    @invoice
  end

  private
    def build_ticket_cost(passenger)
      build_line_item(passenger.full_name, price, :debit)
    end

    def build_additional_charges(passenger)
      fetch_charges.each do |charge|
        amount = calculate_amount(charge.percentage)
        description = set_description(charge)
        build_line_item(description, amount, :debit)
      end
    end

    def build_passenger_discount(passenger)
      passenger_discount = fetch_discount_for_passenger(passenger)
      description = set_description(passenger_discount)
      amount = calculate_amount(passenger_discount.percentage)
      build_line_item(description, amount, :credit)
    end

    def build_client_credit(client)
      if @booking.client.vouchers.any?
        build_line_item('Client Credit', client.vouchers.sum(:amount), :credit)
        @booking.client.vouchers.each do |v|
          v.active = false
          v.save
        end
      end
    end

    def price
      @price ||= round_up(BigDecimal(@booking.stop.cost))
    end

    def fetch_discount_for_passenger(passenger)
      find_seasonal_discount(passenger.passenger_type) || find_discount(passenger.passenger_type)
    end

    def fetch_charges
      Charge.find(@booking.charges.delete_if(&:blank?))
    end

    def build_line_item(description, amount, type)
      @invoice.line_items.build(description: description, amount: amount, line_item_type: type)
    end

    def calculate_amount(percent)
      round_up(Calculations.percentage(percent) * price)
    end

    def set_description(item)
      "#{item.description} - #{Helpers.number_to_percentage(item.percentage, precision: 0)}".capitalize
    end

    def find_seasonal_discount(passenger_type)
      SeasonalDiscount.active_in_period(Date.today).where(passenger_type: passenger_type).take
    end

    def find_discount(passenger_type)
      Discount.find_by(passenger_type: passenger_type)
    end

    def round_up(cost)
      Calculations.roundup(cost)
    end
end
