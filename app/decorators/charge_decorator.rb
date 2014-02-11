class ChargeDecorator < Draper::Decorator
  delegate_all

  def percentage
    h.number_to_percentage(model.percentage, precision: 1)
  end
end
