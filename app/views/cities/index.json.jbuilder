json.array!(@cities) do |city|
  json.cache! city do
   json.extract! city, :id, :name
  end
end
