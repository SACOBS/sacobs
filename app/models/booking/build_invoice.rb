
class Booking::BuildInvoice
  delegate :return_booking, to: :booking

  def self.perform(*args)
    new(*args).perform
  end

  def initialize(booking)
    @booking = booking
  end

  def perform
    [booking, return_booking].compact.each do |booking|
      invoice = build_invoice(booking)
      booking.passengers.each do |passenger|
        total = booking.connection.cost
        build_line_item(invoice, passenger.full_name, booking.connection.cost, :debit)

        passenger.charges.each do |charge|
          amount = charge.percentage.percent_of(booking.connection.cost).round_up(5)
          total += amount
          build_line_item(invoice, charge.description, amount, :debit)
        end

        amount = passenger.discount.percentage.percent_of(total).round_up(5)
        build_line_item(invoice, passenger.discount.description, amount, :credit)
      end
    end
  end

  private

  attr_reader :booking

  def build_invoice(booking)
    booking.build_invoice
  end

  def build_line_item(invoice, description, amount, type)
    invoice.line_items.build(description: description, amount: amount, line_item_type: type)
  end
  end
