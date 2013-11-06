class ConnectionDecorator < Draper::Decorator
  delegate_all

  def from_city
    model.from_city.name
  end

  def to_city
    model.to_city.name
  end

  def distance
    h.number_to_human(model.distance, units: :distance)
  end

  def percentage
    h.number_to_percentage(model.percentage, precision: 0)
  end

  def cost
    h.number_to_currency(model.cost, unit: 'R')
  end
end
