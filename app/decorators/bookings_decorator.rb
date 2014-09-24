class BookingsDecorator < CollectionDecorator

   def decorated_collection
     @decorated_collection ||= collection.map {|item| BookingDecorator.decorate(item, @view_context)}
   end

end