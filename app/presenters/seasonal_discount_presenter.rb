class SeasonalDiscountPresenter

  attr_reader :seasonal_discount

  delegate :period_from, :period_to, to: :seasonal_discount

  def initialize(seasonal_discount, view_context)
    @seasonal_discount = seasonal_discount
    @view_context = view_context
  end

  def name
    seasonal_discount.name.presence || 'N/A'
  end

  def passenger_type
    seasonal_discount.passenger_type_description.titleize
  end

  def percentage
    @view_context.number_to_percentage(seasonal_discount.percentage, precision: 2)
  end

  def active
    seasonal_discount.active? ? 'Yes' : 'No'
  end

  def activation_link
    if seasonal_discount.active?
      @view_context.link_to 'Deactivate', @view_context.seasonal_discount_path(seasonal_discount, seasonal_discount: {active: false}), icon: :times,  method: :patch, class: @view_context.t('buttons.mini.danger')
    else
      @view_context.link_to 'Activate', @view_context.seasonal_discount_path(seasonal_discount, seasonal_discount: {active: true}), icon: :times,  method: :patch, class: @view_context.t('buttons.mini.danger')
    end
  end


end