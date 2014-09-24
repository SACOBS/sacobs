class BookingDashboard

  attr_reader :standby, :cancelled, :paid, :reserved, :bookings
  def initialize(params, view_context)
    @params = params
    @view_context = view_context
  end

  def bookings
   @bookings ||= Booking.includes(:trip, :stop, :client).not_in_process.active.search(@params[:q]).result.distinct(true)
  end

  def reserved
    @reserved ||= BookingsDecorator.new(bookings.open.page(@params[:reserved_page]), @view_context)
  end

  def standby
    @standby ||= BookingsDecorator.new(bookings.standby.page(@params[:standby_page]), @view_context)
  end

  def paid
    @paid ||= BookingsDecorator.new(bookings.paid.page(@params[:paid_page]), @view_context)
  end

  def cancelled
    @cancelled ||= BookingsDecorator.new(bookings.cancelled.page(@params[:cancelled_page]), @view_context)
  end
end

