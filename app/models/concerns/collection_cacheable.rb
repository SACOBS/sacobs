module CollectionCacheable
  extend ActiveSupport::Concern

  module ClassMethods
    def cache_key
      model_identifier = name.underscore.pluralize
      relation_identifier = Digest::MD5.hexdigest(@relation.to_sql.downcase)
      max_updated_at = @relation.maximum(:updated_at).try(:utc).try(:to_s, :number)

      "#{model_identifier}/#{relation_identifier}-#{count}-#{max_updated_at}"
    end
  end
end
