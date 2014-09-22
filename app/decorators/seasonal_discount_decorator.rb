class SeasonalDiscountDecorator < Draper::Decorator
  delegate_all

  def name
    model.name || 'N/A'
  end

  def passenger_type
    model.passenger_type.description.titleize
  end

  def percentage
    h.number_to_percentage(model.percentage, precision: 2)
  end

  def active
    model.active? ? 'Yes' : 'No'
  end

  def activation_link
    if model.active?
      h.link_to 'Deactivate', h.seasonal_discount_path(seasonal_discount, seasonal_discount: {active: false}), icon: :times,  method: :patch, class: h.t('buttons.mini.danger')
    else
       h.link_to 'Activate', h.seasonal_discount_path(seasonal_discount, seasonal_discount: {active: true}), icon: :times,  method: :patch, class: h.t('buttons.mini.danger')
    end
  end
end