class DiscountDecorator < Draper::Decorator
  delegate_all

  def passenger_type
    model.passenger_type.description.capitalize
  end

  def percentage
    h.number_to_percentage(model.percentage, precision: 1)
  end
end
