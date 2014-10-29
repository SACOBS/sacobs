class SeasonalDiscountDecorator < BaseDecorator
  def name
    model.name.presence || 'N/A'
  end

  def passenger_type
    passenger_type_description.titleize
  end

  def percentage
    helpers.number_to_percentage(model.percentage, precision: 2)
  end

  def period_from
    helpers.l(model.period_from, format: :long)
  end

  def period_to
    helpers.l(model.period_to, format: :long)
  end

  def active
    active? ? 'Yes' : 'No'
  end

  def activation_link(options = {})
    options.merge!(method: :patch)
    if active?
      helpers.link_to 'Deactivate', helpers.seasonal_discount_path(model, seasonal_discount: { active: false }), options
    else
      helpers.link_to 'Activate', helpers.seasonal_discount_path(model, seasonal_discount: { active: true }), options
    end
  end
end
