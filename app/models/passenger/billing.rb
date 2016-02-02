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
        amount: calculate_percentage(charge.percentage, base)
      }
    end
  end

  def discount
    {
      description: applicable_discount.description,
      amount: calculate_percentage(applicable_discount.percentage, gross)
    }
  end

  def gross
    base + total_charges
  end

  def total_charges
    charges.sum { |charge| charge[:amount] }
  end

  def nett
    round_up(gross - discount[:amount])
  end

  private

  def calculate_percentage(percentage, amount)
    Utilities::Calculations.percentage_of(percentage, amount)
  end

  def round_up(amount, by = 5)
    Utilities::Calculations.round_up(amount, by)
  end

  def applicable_discount
    @applicable_discount ||= (seasonal_discount || Discount.find_by(passenger_type: passenger.passenger_type))
  end

  def seasonal_discount
    @seasonal_discount ||= SeasonalDiscount.applicable.find_by(passenger_type: passenger.passenger_type)
  end
end
