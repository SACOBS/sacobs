module CacheHelper

  def self.cache_key_for_collection(collection, suffix='')
    ids = collection.pluck(:id).join('-')
    count = collection.model.count
    max_updated_at = collection.model.pluck(:updated_at).max
    collection_name = collection.model.to_s.downcase.pluralize
    Digest::MD5.hexdigest "#{collection_name}_#{count}/#{ids}-#{max_updated_at.to_i}#{collection.to_sql}"
  end
end