class RouteDecorator < Draper::Decorator
  delegate_all

  decorates_association :connections

  def start_city
    destinations.first.city.name if destinations.any?
  end

  def end_city
    destinations.last.city.name if destinations.any?
  end

  def cost
    h.number_to_currency(model.cost, unit: 'R')
  end

  def distance
    h.number_to_human(model.distance, units: :distance)
  end
end
