class CollectionDecorator
  include Enumerable

  delegate :==, :as_json, *(Array.instance_methods - Object.instance_methods), to: :decorated_collection

  attr_reader :collection
  def initialize(collection, view_context=nil)
    @collection = collection
    @view_context = view_context
  end

  def entry_name
    collection.entry_name
  end

  def offset_value
    collection.offset_value
  end

  def last_page?
    collection.last_page?
  end

  def current_page
    collection.current_page
  end

  def total_count
    collection.total_count
  end

  def limit_value
    collection.limit_value
  end

  def total_pages
    collection.total_pages
  end

  def decorated_collection
    []
  end
end