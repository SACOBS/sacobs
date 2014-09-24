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
    @cost ||= round_up(@connection.cost)
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
      round_up(percentage * cost)
    end

    def calculate_price
      round_up(cost)
    end

    def round_up(cost)
        (cost / 5.0).ceil * 5
    end

    def find_seasonal_discount(passenger_type)
      seasonal_discounts.select {|sd| sd.passenger_type == passenger_type}.first
    end

    def find_discount(passenger_type)
      discounts.select { |d| d.passenger_type == passenger_type }.first
    end

    def discounts
      @discounts ||= Discount.all.to_a
    end

    def seasonal_discounts
      @seasonal_discounts||= SeasonalDiscount.active_in_period(Date.today).to_a
    end

    def passenger_types
      @passenger_types ||= PassengerType.all
    end
end