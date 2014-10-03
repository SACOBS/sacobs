module Calculations
  module_function

  def percentage(value)
    BigDecimal(value / 100)
  end

  def roundup(amount)
    (amount / 5.0).ceil * 5
  end
end
