class PassengerBillingDetail
  module Helpers
    extend ActionView::Helpers::NumberHelper
  end

  def initialize(passenger, booking)
    @passenger = passenger
    @price = booking.stop.cost
  end

  def ticket_item
    BillingItem.new("#{@passenger.full_name} ticket", @price, :debit)
  end

  def discount_item
    @discount_item ||= begin
      discount = fetch_discount
      description = "#{discount.description} - #{Helpers.number_to_percentage(discount.percentage * 100, precision: 0)}".capitalize
      amount = Calculations.roundup(total_cost * discount.percentage)
      BillingItem.new(description, amount, :credit)
    end
  end

  def charge_items
    return [] unless @passenger.charge_ids
    charges =  fetch_charges(@passenger.charge_ids)
    @charge_items ||= charges.map do |charge|
      description = "#{charge.description} charge - #{Helpers.number_to_percentage(charge.percentage * 100, precision: 0)}".capitalize
      amount = Calculations.roundup(@price * charge.percentage)
      BillingItem.new(description, amount, :debit)
    end
  end

  def billing_items
    [ticket_item]  + charge_items + [discount_item]
  end

  private
   def fetch_charges(ids)
     Charge.find(ids)
   end

   def fetch_discount
       find_seasonal_discount || find_discount
   end

    def find_seasonal_discount
      SeasonalDiscount.active_in_period(Date.today).where(passenger_type: @passenger.passenger_type).take
    end

    def find_discount
      Discount.find_by(passenger_type: @passenger.passenger_type)
    end

    def total_charges
      charge_items.reduce(0) {|sum, c| sum += c.amount}
    end

    def total_cost
      Calculations.roundup(@price + total_charges)
    end
end