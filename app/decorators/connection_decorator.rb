class ConnectionDecorator < Draper::Decorator
  delegate_all

  def from_destination
    model.from_destination.try(:name) || 'None'
  end

  def to_destination
    model.to_destination.try(:name) || 'None'
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
