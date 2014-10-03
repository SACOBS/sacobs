class InvoiceBuilder
  include Service

  def initialize(booking)
    @booking = booking
    @invoice = Invoice.new
  end

  def execute
    passenger_billing_details.each do |detail|
      detail.billing_items.each { |item| build_line_item(item.description, item.amount, item.type) }
    end
    build_client_credit(@booking.client)
    @invoice
  end

  private

  def passenger_billing_details
    @booking.passengers.map { |p| PassengerBillingDetail.new(p, @booking) }
  end

  def build_client_credit(client)
    if @booking.client.vouchers.any?
      build_line_item('Client Credit', client.vouchers.sum(:amount), :credit)
      @booking.client.vouchers.update_all(active: :false)
    end
  end

  def build_line_item(description, amount, type)
    @invoice.line_items.build(description: description, amount: amount, line_item_type: type)
  end
end
