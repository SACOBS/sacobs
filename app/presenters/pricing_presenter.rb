class PricingPresenter
  attr_reader :discount_prices, :price, :charges

  def initialize(connection)
    @connection = connection
    build_discounts
    build_charges
  end

  def connection_name
    @connection_name ||= @connection.name
  end

  def price
    @price ||= @connection.cost
  end

  private

  def build_discounts
    @discount_prices = {}
    passenger_types.each do |passenger_type|
      discount = find_seasonal_discount(passenger_type) || find_discount(passenger_type)
      if discount
        key = discount.description
        @discount_prices[key] = calculate_percentage(discount.percentage, price)
      end
    end
  end

  def build_charges
    @charges = {}
    Charge.all.each do |charge|
      key = charge.description
      @charges[key] = calculate_percentage(charge.percentage, price)
    end
  end

  def calculate_percentage(percentage, amount)
    Utilities::Calculations.percentage_of(percentage, amount).round
  end

  def round_up(amount, by = 5)
    Utilities::Calculations.round_up(amount, by)
  end

  def find_seasonal_discount(passenger_type)
    seasonal_discounts.find { |seasonal_discount| seasonal_discount.passenger_type == passenger_type }
  end

  def find_discount(passenger_type)
    discounts.find { |discount| discount.passenger_type == passenger_type }
  end

  def discounts
    @discounts ||= Discount.includes(:passenger_type).all.to_a
  end

  def seasonal_discounts
    @seasonal_discounts ||= SeasonalDiscount.includes(:passenger_type).applicable.to_a
  end

  def passenger_types
    Rails.cache.fetch(PassengerType.all.cache_key) do
      PassengerType.all
    end
  end
end
