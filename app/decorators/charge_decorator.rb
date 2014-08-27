class ChargeDecorator < Draper::Decorator
  delegate_all

  def percentage
    h.number_to_percentage(model.percentage * 100, precision: 1)
  end
end
