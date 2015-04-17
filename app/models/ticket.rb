class Ticket
  attr_reader :booking, :return_booking, :client

  delegate :reference_no, :passengers, to: :booking

  def initialize(booking, view_context)
    @booking = booking.main ? booking.main : booking
    @return_booking = @booking.return_booking if @booking.return_booking
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
    booking.from_city_name
  end

  def from_venue
    booking.from_city.venues.first.name
  end

  def to_venue
    booking.to_city.venues.first.name
  end

  def to_city
    booking.to_city_name
  end

  def depart_time
    booking.depart.try(:strftime, '%I:%M %P') || Time.now.strftime('%I:%M %P')
  end

  def arrive_time
    booking.arrive.try(:strftime, '%I:%M %P') || Time.now.strftime('%I:%M %P')
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
    booking.status.to_s.upcase
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
    total = 0
    total += booking.invoice_total
    total += return_booking.invoice_total if @return
    total
  end

  def total_cost
    total = 0
    total += booking.invoice_total_cost
    total += return_booking.invoice_total_cost if @return
    total
  end

  def total_discount
    total = 0
    total += booking.invoice_total_discount
    total += return_booking.invoice_total_discount if @return
    total
  end
end
