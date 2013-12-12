class TripDecorator < Draper::Decorator
  delegate_all

  def start_date
    return 'None' unless model.start_date
    l(model.start_date, format: :long)
  end

  def end_date
   return 'None' unless model.end_date
   l(model.end_date, format: :long)
  end

  def route
    model.route.try(:name) || 'None'
  end

  def bus
    model.bus.try(:name) || 'None'
  end
end
