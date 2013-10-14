json.array!(@trips) do |trip|
  json.extract! trip, 
  json.url trip_url(trip, format: :json)
end
