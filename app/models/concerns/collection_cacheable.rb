module CollectionCacheable
  extend ActiveSupport::Concern

  module ClassMethods
    def cache_key
      "#{model_name.route_key}/#{ids.join('-')}/#{maximum(:updated_at).to_i}"
    end
  end
end
