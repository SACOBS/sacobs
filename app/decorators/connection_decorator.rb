class ConnectionDecorator < LittleDecorator
  def distance
    number_to_human(record.distance, units: :distance)
  end

  def cost
    number_to_currency(record.cost)
  end

  def percentage
    number_to_percentage(record.percentage, precision: 0)
  end
end