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

  def cost
    @connection.cost
  end

  def price
    @price ||= calculate_price
  end

  private

  def build_discounts
    @discount_prices = {}
    passenger_types.each do |passenger_type|
      discount = find_seasonal_discount(passenger_type) || find_discount(passenger_type)
      if discount
        key = discount.description
        @discount_prices[key] = calculate_percentage_amount(discount.percentage)
      end
    end
  end

  def build_charges
    @charges = {}
    Charge.all.each do |charge|
      key = charge.description
      @charges[key] = calculate_percentage_amount(charge.percentage)
    end
  end

  def calculate_percentage_amount(percentage)
    percentage.percent_of(cost).round_up(5)
  end

  def calculate_price
    cost.round_up(5)
  end

  def find_seasonal_discount(passenger_type)
    seasonal_discounts.find { |seasonal_discount| seasonal_discount.passenger_type == passenger_type }
  end

  def find_discount(passenger_type)
    discounts.find { |discount| discount.passenger_type == passenger_type }
  end

  def discounts
    @discounts ||= Discount.all.to_a
  end

  def seasonal_discounts
    @seasonal_discounts ||= SeasonalDiscount.active_in_period(Date.current).to_a
  end

  def passenger_types
    Rails.cache.fetch(PassengerType.all.cache_key) do
      PassengerType.all
    end
  end
end
