class BillingService

  attr_reader :original_amount, :discount_percentage

  def initialize(amount, discount_percentage)
    @original_amount = amount.to_d
    @discount_percentage = discount_percentage.to_d
  end

  def discount
   ((discount_percentage / 100) * original_amount).round(2)
  end

  def new_amount
   BigDecimal(original_amount - discount).round(2)
  end
end