class Trip::Copy
  def self.perform(*args)
    new(*args).perform
  end

  def initialize(trip, user)
    @trip = trip
    @user = user
  end

  def perform
    copy = trip.dup
    copy.name = "Copy of #{trip.name}"
    copy.drivers = trip.drivers.map(&:dup)
    copy.stops = trip.stops.map(&:dup)
    copy.user_id = user.id
    copy
  end

  private

  attr_reader :trip, :user
end
