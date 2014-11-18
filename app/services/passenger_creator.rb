class PassengerCreator
  include Service

  def initialize(booking)
    @booking = booking
  end

  def execute
    clear_passengers
    build_passengers
    @booking.save
  end

  private

  def build_passengers
    passenger_type ||= get_passenger_type
    @booking.quantity.times {  @booking.passengers.build(passenger_type: passenger_type) }
  end

  def clear_passengers
    @booking.passengers.clear if @booking.passengers.any?
  end

  def get_passenger_type
    PassengerType.find_by(description: :pensioner) if @booking.client_is_pensioner?
  end
end
