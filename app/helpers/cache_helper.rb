module CacheHelper
  def cache_key_for_collection(collection, suffix='')
    ids = collection.pluck(:id).join('-')
    max_updated_at = collection.pluck(:updated_at).max
    collection_name = collection.model.to_s.downcase.pluralize
    "#{collection_name}/#{ids}-#{max_updated_at.to_i}#{suffix}"
  end

  def build_cache_key_from_ransack_search(search_obj)
    if search_obj && search_obj.conditions.any?
      fields = search_obj.conditions.map {|c| c.attributes.map(&:name).join('-') }.join('-')
      values = search_obj.conditions.map {|c| c.values.map(&:value).join('-') }.join('-')
      "#{fields}-#{values}"
    end
  end

end