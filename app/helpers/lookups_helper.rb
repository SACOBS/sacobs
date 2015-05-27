module LookupsHelper
  def cities
    Rails.cache.fetch(City.cache_key) do
      City.all.to_json(only: [:id, :name])
    end
  end

  def clients
    Rails.cache.fetch(Client.cache_key) do
      Client.all.to_json(except: [:created_at, :updated_at], methods: :full_name)
    end
  end
end
