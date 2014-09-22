class Ticket

attr_reader :booking, :return ,:client

  def initialize(booking)
    @booking = booking.main ? booking.main.decorate : booking.decorate
    @return = @booking.return_booking if @booking.return_booking
    @client = @booking.client
  end

  def passengers
    @passengers ||= booking.passengers
  end

  def total
    total = 0
    total += @booking.invoice_total
    total += @return.invoice_total if @return
    total
  end

  def total_cost
    total = 0
    total += @booking.invoice_total_cost
    total += @return.invoice_total_cost if @return
    total
  end


  def total_discount
    total = 0
    total += @booking.invoice_total_discount
    total += @return.invoice_total_discount if @return
    total
  end
end