module TripHelper
  def display_occupancy(trip)
    items = calculate_statistics(trip)
    render partial: 'trips/occupancy.html.erb', locals: { capacity: trip.bus.capacity, items: items }
  end

  private

  def calculate_statistics(trip)
    key = cache_key(trip)
    Rails.cache.fetch(key) do
      Trip::Occupancy.new(trip).statistics
    end
  end

  def cache_key(trip)
    "trips/#{trip.id}/occupancy/#{trip.updated_at.to_i}-#{trip.bookings.size}"
  end
end
