module BookingsHelper
  def status_label_for(booking)
    content_tag :span, booking.status.upcase, class: {reserved: 'label label-info', paid: 'label label-success', cancelled: 'label label-important'}.with_indifferent_access[booking.status]
  end
end