class Passenger::Billing
  attr_reader :passenger, :discount, :charges, :base

  def initialize(passenger, base)
    @passenger = passenger
    @base = base
  end

  def charges
    passenger.charges.map do |charge|
      {
        description: charge.description,
        amount: charge.percentage.percent_of(base).round_up(5)
      }
    end
  end

  def discount
    {
      description: applicable_discount.description,
      amount: applicable_discount.percentage.percent_of(gross).round_up(5)
    }
  end

  def gross
    (base + total_charges).round_up(5)
  end
  
  def total_charges
     charges.sum { |charge| charge[:amount] } 
  end 

  def nett
    (gross - discount[:amount]).round_up(5)
  end

  private

  def applicable_discount
    @applicable_discount ||= (seasonal_discount || Discount.find_by(passenger_type: passenger.passenger_type))
  end

  def seasonal_discount
    @seasonal_discount ||= SeasonalDiscount.applicable.find_by(passenger_type: passenger.passenger_type)
  end
end
