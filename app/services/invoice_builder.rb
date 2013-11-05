class InvoiceBuilder

  attr_reader :invoice, :booking

  def initialize(booking)
    @booking = booking
    @invoice = booking.build_invoice
  end

  def build
    price = BigDecimal(booking.stops.cost)
    booking.passengers.each do |passenger|
      build_line_item(price, passenger )
    end
    invoice
  end

  private
    def build_line_item(price, passenger)
     invoice.line_items.build do |line_item|
       line_item.description = passenger.full_name
       line_item.discount_percentage = 10
       line_item.discount_amount = calculate_discount(price, line_item.discount_percentage)
       line_item.amount = price
     end
    end

    def calculate_discount(price, percentage)
      percentage = BigDecimal(percentage)
      ((percentage / 100) * price).round(2)
    end
end