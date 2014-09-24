class ClientsDecorator < CollectionDecorator

  def decorated_collection
    @decorated_collection ||= collection.map {|item| ClientDecorator.decorate(item, @view_context)}
  end

end