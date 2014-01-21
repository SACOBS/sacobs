class TripDecorator < Draper::Decorator
  delegate_all

  def start_date
   return 'None' unless model.start_date
   model.start_date
  end

  def end_date
   return 'None' unless model.end_date
   model.end_date
  end

  def connections
    stops.map { |s| s.connection }
  end

  def route
    model.route.try(:name) || 'None'
  end

  def bus
    model.bus.try(:name) || 'None'
  end

  def created_at
    model.created_at
  end

end
