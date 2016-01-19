module LookupsHelper
  def cities
    @cities ||= Rails.cache.fetch(City.all.cache_key) do
      City.select(:id, :name)
    end
  end

  def clients
    @clients ||= Rails.cache.fetch(Client.all.cache_key) do
      Client.select(:id, :name, :surname)
    end
  end
end
