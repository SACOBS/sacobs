module CollectionCacheable
  extend ActiveSupport::Concern

  module ClassMethods
    def collection_cache_key
      "#{self.model_name.route_key}/#{count}/#{maximum(:updated_at).to_i}"
    end
  end
end
