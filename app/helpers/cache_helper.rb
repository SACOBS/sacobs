module CacheHelper

  def cache_key_for_collection(*args)
    CacheHelper.cache_key_for_collection(*args)
  end

  def build_cache_key_from_ransack_search(*args)
    CacheHelper.build_cache_key_from_ransack_search(*args)
  end

  def self.cache_key_for_collection(collection, suffix='')
    ids = collection.pluck(:id).join('-')
    count = collection.model.count
    max_updated_at = collection.pluck(:updated_at).max
    collection_name = collection.model.to_s.downcase.pluralize
    "#{collection_name}_#{count}/#{ids}-#{max_updated_at.to_i}#{suffix}"
  end

  def self.build_cache_key_from_ransack_search(search_obj)
    if search_obj && search_obj.conditions.any?
      fields = search_obj.conditions.map {|c| c.attributes.map(&:name).join('-') }.join('-')
      values = search_obj.conditions.map {|c| c.values.map(&:value).join('-') }.join('-')
      "#{fields}-#{values}"
    end
  end

end