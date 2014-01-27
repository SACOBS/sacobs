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
    @fees ||= calculate_percentage_amount(markup.percentage)
  end

  def markup
    @markup ||= SeasonalMarkup.in_period(Date.today).active.take
  end


  private
    def build_discounts
       @discounts = Hash.new
       Discount.includes(:passenger_type).each do |d|
         key = "#{d.passenger_type.description.downcase}_discount".to_sym
         @discounts[key] = calculate_percentage_amount(d.percentage)
       end
    end

    def calculate_percentage_amount(percentage)
      percentage = BigDecimal(percentage / 100)
      round_up(percentage * cost)
    end

    def calculate_price
      round_up(fees + cost)
    end

    def round_up(cost)
        (cost / 5.0).ceil * 5
    end
end