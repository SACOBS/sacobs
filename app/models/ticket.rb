class Ticket

attr_reader :booking, :return ,:client

  def initialize(booking)
    if booking.has_return?
      @booking = booking.decorate
      @return = booking.return.decorate if @booking.return
    else
      if booking.return
        @booking = booking.main.decorate
        @return = booking.decorate
      else
        @booking = booking.decorate
      end
    end
    @client = booking.client.decorate
  end

  def passengers
    @passengers ||= booking.passengers
  end

  def total
    total = @booking.invoice.total
    return_total = @return.invoice.total if @return
    total += (return_total || 0)
  end

  def total_discount
    total = @booking.invoice.total_discount
    return_total = @return.invoice.total_discount if @return
    total += (return_total || 0)
  end

end