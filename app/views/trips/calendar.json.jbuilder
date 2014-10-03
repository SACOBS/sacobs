json.array!(trips) do |trip|
  json.extract! trip, :id
  json.title "#{trip.route} #{trip.bus}"
  json.start trip.start_date
  json.url trip_url(trip, format: :html)
end
