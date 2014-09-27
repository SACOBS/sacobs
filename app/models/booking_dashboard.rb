class BookingDashboard

  attr_reader :standby, :cancelled, :paid, :reserved, :bookings
  def initialize(bookings, params)
    @bookings = bookings
    @params = params
  end

  def reserved
    @reserved ||= paginate_array(bookings.select(&:open?), @params[:reserved_page])
  end

  def standby
    @standby ||= paginate_array(bookings.select(&:standby?), @params[:standby_page])
  end

  def paid
    @paid ||= paginate_array(bookings.select(&:paid?),@params[:paid_page])
  end

  def cancelled
    @cancelled ||= paginate_array(bookings.select(&:cancelled?), @params[:cancelled_page])
  end

  private
   def paginate_array(array, page)
     Kaminari.paginate_array(array).page(page)
   end

end

