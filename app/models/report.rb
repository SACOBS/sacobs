# == Schema Information
#
# Table name: reports
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  criteria    :json             default({}), not null
#  period_from :date
#  period_to   :date
#  daily       :boolean          default(FALSE)
#

class Report < ActiveRecord::Base
  validates :name, presence: true

  before_save :adjust_period_from, if: :period_from?
  before_save :adjust_period_to, if: :period_to?

  def from_city
    @from_city ||= City.where(id: criteria["stop_connection_from_city_id_eq"]).pluck(:name)
  end

  def to_city
    @to_city ||= City.where(id: criteria["stop_connection_to_city_id_eq"]).pluck(:name)
  end

  def to_file_name
    "#{name}_#{Time.current.to_i}".tr(" ", "_").downcase
  end

  def date_range
    daily? ? Date.current.beginning_of_day..Date.current.end_of_day : period_from..period_to
  end

  def results
    @results ||= Booking.completed
                        .joins(:client, :trip, stop: :connection)
                        .where(created_at: date_range).search(criteria)
                        .result.select(
                          "trips.name as trip_name",
                          "trips.start_date as trip_date",
                          :status,
                          :price,
                          :quantity,
                          "concat_ws(' ', clients.name, clients.surname) as client_name",
                          "connections.name as connection_name"
                        )
  end

  private

  def adjust_period_from
    self.period_from = period_from.beginning_of_month
  end

  def adjust_period_to
    self.period_to = period_to.end_of_month
  end
end
