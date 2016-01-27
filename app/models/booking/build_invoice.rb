
class Booking::BuildInvoice
  def self.perform(*args)
    new(*args).perform
  end

  def initialize(booking)
    @booking = booking
    @return_booking = booking.return_booking
  end

  def perform
    [booking, return_booking].compact.each do |booking|
      booking.build_invoice do |invoice|
        booking.passengers.each do |passenger|
          bill = Passenger::Billing.new(passenger, booking.connection.cost)
          add_base(invoice, bill)
          add_charges(invoice, bill)
          add_discount(invoice, bill)
        end
      end
    end
  end

  private

  attr_reader :booking, :return_booking

  def add_base(invoice, bill)
    invoice.line_items.debit.build(description: passenger.full_name, amount: bill.base)
  end

  def add_charges(invoice, bill)
    bill.charges.each do |charge|
      invoice.line_items.debit.build(description: charge[:description], amount: charge[:amount])
    end
  end

  def add_discount(invoice, bill)
    invoice.line_items.credit.build(description: bill.discount[:description], amount: bill.discount[:amount])
  end

end
