# == Schema Information
#
# Table name: bookings
#
#  id                :integer          not null, primary key
#  trip_id           :integer
#  price             :decimal(, )      default(0.0)
#  status            :integer          default(0)
#  created_at        :datetime
#  updated_at        :datetime
#  quantity          :integer          default(0)
#  expiry_date       :datetime
#  client_id         :integer
#  user_id           :integer
#  reference_no      :string(255)
#  main_id           :integer
#  stop_id           :integer
#  sequence_id       :integer
#  archived          :boolean          default(FALSE)
#  archived_at       :datetime
#  payment_detail_id :integer
#
# Indexes
#
#  index_bookings_on_archived   (archived)
#  index_bookings_on_client_id  (client_id)
#  index_bookings_on_main_id    (main_id)
#  index_bookings_on_stop_id    (stop_id)
#  index_bookings_on_trip_id    (trip_id)
#

module BookingsHelper
  def status_label_for(booking)
    content_tag :span, booking.status.upcase, class: {reserved: "label label-info", paid: "label label-success", cancelled: "label label-important"}.with_indifferent_access[booking.status]
  end

  def badge_for(value, type=:inverse)
    content_tag :span, value, class: "badge badge-#{type}"
  end

  def row_class_for(booking)
    if booking.standby?
      "warning"
    elsif booking.paid?
      "success"
    elsif booking.cancelled?
      "error"
    else
      "info"
    end
  end
end
