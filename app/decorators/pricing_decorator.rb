class PricingDecorator

  attr_reader :discounts, :price, :seasonal_price


  def initialize(stop)
    @stop = stop
    build_discounts
  end

  def connection_name
    @connection_name ||= @stop.connection.name
  end

  def cost
    @cost ||= round_up(BigDecimal(@stop.cost))
  end

  def price
    @price ||= calculate_price
  end

  def fees
    return 0 unless markup
    @fees ||= calculate_percentage_amount(markup.percentage)
  end

  private
    def build_discounts
       @discounts = {}
       PassengerType.all.each do |passenger_type|
         discount = find_seasonal_discount(passenger_type) || find_discount(passenger_type)
         key = discount.description.to_sym
         @discounts[key] = calculate_percentage_amount(discount.percentage)
       end
    end

    def calculate_percentage_amount(percentage)
      round_up(percentage * cost)
    end

    def calculate_price
      round_up(cost)
    end

    def round_up(cost)
        (cost / 5.0).ceil * 5
    end

    def find_seasonal_discount(passenger_type)
      SeasonalDiscount.active_in_period(Date.today).where(passenger_type: passenger_type).take
    end

    def find_discount(passenger_type)
      Discount.find_by(passenger_type: passenger_type)
    end
end