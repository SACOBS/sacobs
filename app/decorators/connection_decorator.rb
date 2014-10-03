class ConnectionDecorator < BaseDecorator
  def from_city
    model.from_city_name
  end

  def to_city
    model.to_city_name
  end

  def distance
    @view_context.number_to_human(model.distance, units: :distance)
  end

  def percentage
    @view_context.number_to_percentage(model.percentage, precision: 0)
  end

  def cost
    @view_context.number_to_currency(model.cost, unit: 'R')
  end

  def arrive_time
    model.arrive.strftime('%H:%M%p') if model.arrive?
  end

  def depart_time
    model.depart.strftime('%H:%M%p') if model.depart?
  end
end
