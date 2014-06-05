class SeasonalDiscountDecorator < Draper::Decorator
  delegate_all

  def passenger_type
    model.passenger_type.description.titleize
  end

  def percentage
    h.number_to_percentage(model.percentage, precision: 2)
  end

  def active
    model.active? ? 'Yes' : 'No'
  end
end