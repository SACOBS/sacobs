module LookupsHelper
  def cities
    Rails.cache.fetch(cache_key('city')) do
      City.all.to_json(only: [:id, :name])
    end
  end

  def clients
    Rails.cache.fetch(cache_key('client')) do
      Client.all.to_json(except: [:created_at, :updated_at], methods: :full_name)
    end
  end

  private
  def cache_key(model)
    "#{model.pluralize}/#{model.classify.constantize.count}/#{model.classify.constantize.maximum(:updated_at).to_i}"
  end
end