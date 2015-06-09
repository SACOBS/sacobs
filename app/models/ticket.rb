class Ticket
  attr_reader :booking, :return_booking, :client

  delegate :status, :reference_no, :passengers, to: :booking

  def initialize(booking, view_context)
    @booking = booking.main || booking
    @return_booking = booking.return_booking
    @client = @booking.client
    @view_context = view_context
  end

  def instructions
    simple_format(settings.ticket_instructions)
  end

  def scripture
    simple_format(scripture_service.fetch || settings.default_scripture)
  end

  def ticket_date
    l Date.current, format: :long
  end

  def price
    number_to_currency total_cost, unit: 'R'
  end

  def discount
    number_to_currency total_discount, unit: 'R'
  end

  def nett
    number_to_currency total, unit: 'R'
  end

  def to_file_name
    "#{booking.trip_name}_#{booking.client.full_name}_#{Time.current.to_i}".gsub(' ', '_').downcase
  end

  def method_missing(method_name, *args, &block)
    return @view_context.public_send(method_name, *args, &block) if @view_context.respond_to?(method_name)
    super
  end

  def respond_to_missing?(method_name, include_private = false)
    @view_context.respond_to?(method_name, include_private)
  end

  private

  def settings
    @settings ||= Setting.first
  end

  def scripture_service
    @scripture_service ||= ScriptureService.new
  end

  def total
    @total ||= [booking, return_booking].compact.map(&:invoice_total).sum
  end

  def total_cost
    @total_cost ||= [booking, return_booking].compact.map(&:invoice_total_cost).sum
  end

  def total_discount
    @total_discount ||= [booking, return_booking].compact.map(&:invoice_total_discount).sum
  end

  def view_context
    @view_context
  end
end
