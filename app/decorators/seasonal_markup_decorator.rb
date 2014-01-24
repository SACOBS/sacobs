class SeasonalMarkupDecorator < Draper::Decorator
  delegate_all

  def percentage
    h.number_to_percentage(model.percentage, precision: 2)
  end

  def active
    model.active? ? 'Yes' : 'No'
  end
end