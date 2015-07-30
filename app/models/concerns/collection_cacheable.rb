module CollectionCacheable
  extend ActiveSupport::Concern

  module ClassMethods
    def cache_key
      key = Digest::MD5.hexdigest(pluck(:id, :updated_at).map { |id, updated_at| "#{id}-#{updated_at.to_i}" }.to_s)
      "#{model_name.plural}/#{key}"
    end
  end
end
