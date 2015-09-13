class Ticket
  attr_reader :booking, :return_booking, :client

  delegate :status, :reference_no, :passengers, to: :booking

  def initialize(booking, view_context, settings)
    @booking = booking.main || booking
    @return_booking = booking.return_booking
    @client = @booking.client
    @view_context = view_context
    @settings = settings
  end

  def instructions
    view_context.simple_format(@settings.ticket_instructions)
  end

  def scripture
    content = Rails.cache.fetch('scripture_for_today', expires_in: 8.hours) do
      Bible::Scripture.for_today || @settings.default_scripture
    end
    view_context.simple_format(content)
  end

  def price
    view_context.number_to_currency total_cost, unit: 'R'
  end

  def discount
    view_context.number_to_currency total_discount, unit: 'R'
  end

  def nett
    view_context.number_to_currency total, unit: 'R'
  end

  def to_file_name
    "#{booking.trip.name}_#{booking.client.full_name}_#{Time.current.to_i}".tr(' ', '_').downcase
  end

  private

  def total
    @total ||= [booking, return_booking].compact.sum { |booking| booking.invoice.total }
  end

  def total_cost
    @total_cost ||= [booking, return_booking].compact.sum { |booking| booking.invoice.total_cost }
  end

  def total_discount
    @total_discount ||= [booking, return_booking].compact.sum { |booking| booking.invoice.total_discount }
  end

  def view_context
    @view_context
  end
end
