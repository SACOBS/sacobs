module TicketHelper
  def scripture_for_today
    Rails.cache.fetch("scripture_for_today", expires_in: 8.hours) do
      Bible::Scripture.for_today || @settings.default_scripture
    end
  end

  def gross_price(*bookings)
    number_to_currency(bookings.compact.sum {|booking| booking.invoice.total_cost })
  end

  def discount(*bookings)
    number_to_currency(bookings.compact.sum {|booking| booking.invoice.total_discount })
  end

  def nett_price(*bookings)
    number_to_currency(bookings.compact.sum {|booking| booking.invoice.total })
  end
end
