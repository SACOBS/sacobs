Numeric.include CoreExtensions::Numeric::RoundUp, CoreExtensions::Numeric::PercentOf

ActiveRecord::Relation.send(:include, CoreExtensions::ActiveRecord::CollectionCacheKey)
