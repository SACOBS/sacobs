module BookingsHelper
  def status_label_for(booking)
    content_tag :span, booking.status.upcase, class: { reserved: 'label label-info', paid: 'label label-success', cancelled: 'label label-important' }.with_indifferent_access[booking.status]
  end

  def badge_for(value, type = :inverse)
    content_tag :span, value, class: "badge badge-#{type}"
  end

  def row_class_for(booking)
    if booking.standby?
      'warning'
    elsif booking.paid?
      'success'
    elsif booking.cancelled?
      'error'
    else
      'info'
    end
  end

  def reserved_booking_count
    Booking.open.size
  end

  def standby_booking_count
    Booking.expired.size
  end

  def paid_booking_count
    Booking.paid.size
  end

  def cancelled_booking_count
    Booking.cancelled.size
  end
end
