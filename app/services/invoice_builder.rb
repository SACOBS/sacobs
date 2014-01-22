class InvoiceBuilder

  def initialize(booking)
    @booking = booking
    @invoice = Invoice.new
  end

  def build
    @booking.passengers.each { |p| build_line_item(booking_cost, p) }
    build_client_credit
    @invoice
  end

  private
    def build_line_item(price, passenger)
     discount = Discount.find_by(passenger_type: passenger.passenger_type)
     @invoice.line_items.build do |line_item|
       line_item.description = passenger.full_name
       line_item.discount_percentage = discount.percentage
       line_item.discount_amount = calculate_discount(price, discount.percentage)
       line_item.gross_price = price
       line_item.nett_price = price - line_item.discount_amount
     end
    end

    def calculate_discount(price, percentage)
      percentage = BigDecimal(percentage)
      round_up(BigDecimal((percentage / 100) * price))
    end

    def build_client_credit
      if @booking.client.vouchers.any?
        @invoice.line_items.build do |line_item|
          line_item.description = 'Client Credit'
          line_item.gross_price =  line_item.nett_price = @booking.client.vouchers.sum(:amount) * -1
        end
        @booking.client.vouchers.each { |v| v.update(active: false)}
      end
    end

    def booking_cost
      round_up(BigDecimal(@booking.stop.connection.cost))
    end

    def round_up(cost)
      (cost / 5.0).ceil * 5
    end
end