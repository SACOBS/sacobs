require "digest/md5"

module RelationCacheKey
  def cache_key
    model_identifier = name.underscore.pluralize
    relation_identifier = Digest::MD5.hexdigest("#{to_sql.downcase} #{ids.join}")
    max_updated_at = maximum(:updated_at).try(:utc).try(:to_s, :number)

    "#{model_identifier}/#{relation_identifier}-#{count}-#{max_updated_at}"
  end
end

ActiveRecord::Relation.send :include, RelationCacheKey