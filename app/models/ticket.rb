class Ticket
  attr_reader :booking, :return_booking, :client

  delegate :reference_no, :passengers, to: :booking

  def initialize(booking, view_context)
    @booking = booking.main ? booking.main : booking
    @return_booking = @booking.return_booking
    @client = @booking.client
    @view_context = view_context
  end

  def instructions
    @view_context.simple_format(settings.ticket_instructions)
  end

  def scripture
    @view_context.simple_format(scripture_service.fetch || settings.default_scripture)
  end

  def ticket_date
    @view_context.l Time.zone.now, format: :long
  end

  def from_city
    booking.stop.connection.from.city.name
  end

  def from_venue
    booking.stop.connection.from.city.venues.first.name
  end

  def to_venue
    booking.stop.connection.to.city.venues.first.name
  end

  def to_city
    booking.stop.connection.to.city.name
  end

  def depart_time
    @view_context.l(booking.stop.connection.arrive, format: :short) if booking.stop.connection.arrive.present?
  end

  def arrive_time
    @view_context.l(booking.stop.connection.arrive, format: :short) if booking.stop.connection.arrive.present?
  end

  def return_depart_time
    return_booking.depart.try(:strftime, '%I:%M %P') || Time.now.strftime('%I:%M %P')
  end

  def return_arrive_time
    return_booking.arrive.try(:strftime, '%I:%M %P') || Time.now.strftime('%I:%M %P')
  end

  def return_from_city
    return_booking.from_city_name
  end

  def return_from_venue
    return_booking.from_city.venues.first.name
  end

  def return_to_venue
    return_booking.to_city.venues.first.name
  end

  def return_to_city
    return_booking.to_city_name
  end

  def status
    booking.status
  end

  def price
    @view_context.number_to_currency total_cost, unit: 'R'
  end

  def discount
    @view_context.number_to_currency total_discount, unit: 'R'
  end

  def nett
    @view_context.number_to_currency total, unit: 'R'
  end

  def to_file_name
    "#{@booking.trip_name}_#{@booking.client_name}_#{Time.zone.now.to_i}".gsub(' ', '_').downcase
  end

  private

  def settings
    @settings ||= Setting.first
  end

  def scripture_service
    @scripture_service ||= ScriptureService.new
  end

  def total
    @total ||= [booking, booking.return_booking].compact.map { |b| b.invoice.total }.sum
  end

  def total_cost
    @total_cost ||= [booking, booking.return_booking].compact.map { |b| b.invoice.total_cost }.sum
  end

  def total_discount
    @total_discount ||= [booking, booking.return_booking].compact.map { |b| b.invoice.total_discount }.sum
  end
end
