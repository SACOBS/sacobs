class TripDecorator < Draper::Decorator
  delegate_all

  def start_date
    l(model.start_date.presence || Date.tomorrow, format: :long)
  end

  def end_date
   l(model.end_date.presence || Date.today, format: :long)
  end

  def route
    model.route.name
  end

  def bus
    model.bus.name
  end
end
