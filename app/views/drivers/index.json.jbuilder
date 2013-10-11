json.array!(@drivers) do |driver|
  json.extract! driver, 
  json.url driver_url(driver, format: :json)
end
