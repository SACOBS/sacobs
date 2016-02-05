json.array!(@trips) do |trip|
  json.extract! trip, :id
  json.title trip.name
  json.description trip.bookings.size
  json.start trip.start_date
  json.end trip.end_date
  json.url trip_sheet_url(trip)
end
