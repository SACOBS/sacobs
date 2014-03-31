class InvoiceBuilder

  def initialize(booking)
    @booking = booking
    @invoice = Invoice.new
  end

  def build
    @booking.passengers.each do |p|
      build_ticket_cost(p)
      build_markup(p)
      build_passenger_discount(p)
    end
    build_client_credit(@booking.client)
    @invoice
  end


  module Helpers
    extend ActionView::Helpers::NumberHelper
  end

  private
    def build_ticket_cost(passenger)
      build_line_item(passenger.full_name, price, :debit)
    end

  def build_markup(passenger)
    if markup
      description = "#{passenger.full_name} Seasonal Fee"
      amount = calculate_markup
      build_line_item(description, amount, :debit)
    end
  end


  def build_passenger_discount(passenger)
      passenger_discount = find_discount(passenger)
      description = "Discount #{passenger.passenger_type.description} - #{Helpers.number_to_percentage(passenger_discount.percentage, precision: 0)}".capitalize
      amount = calculate_discount(passenger_discount)
      build_line_item(description, amount, :credit )
    end


    def build_client_credit(client)
      if @booking.client.vouchers.any?
        build_line_item('Client Credit', client.vouchers.sum(:amount), :credit )
        @booking.client.vouchers.each do |v|
          v.active = false
          v.save
        end
      end
    end

    def price
      @price ||= round_up(BigDecimal(@booking.stop.cost))
    end

    def build_line_item(description, amount, type)
      @invoice.line_items.build(description: description, amount: amount, line_item_type: type)
    end


    def calculate_discount(discount)
     percentage = Calculations.percentage(discount.percentage)
     round_up(percentage * price)
    end

    def markup
      @markup ||= SeasonalMarkup.in_period(Date.today).active.take
    end

    def calculate_markup
      percentage = Calculations.percentage(@markup.percentage)
      round_up(percentage * price)
    end

    def find_discount(passenger)
      Discount.find_by(passenger_type: passenger.passenger_type)
    end

    def round_up(cost)
      Calculations.roundup(cost)
    end
end