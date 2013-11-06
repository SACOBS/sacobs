class RouteDecorator < Draper::Decorator
  delegate_all

  decorates_association :connections

  def cost
    h.number_to_currency(model.cost, unit: 'R')
  end

  def distance
    h.number_to_human(route.distance, units: :distance)
  end

end
