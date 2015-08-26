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
#

class Report < ActiveRecord::Base
  validates :name, presence: true

  before_save :adjust_period_from, if: :period_from?
  before_save :adjust_period_to, if: :period_to?

  def from_city
    @from_city ||= City.where(id: criteria['stop_connection_from_city_id_eq']).pluck(:name)
  end

  def to_city
    @to_city ||= City.where(id: criteria['stop_connection_to_city_id_eq']).pluck(:name)
  end

  def to_file_name
    "#{name}_#{Time.current.to_i}".tr(' ', '_').downcase
  end

  private

  def adjust_period_from
    self.period_from = period_from.beginning_of_month
  end

  def adjust_period_to
    self.period_to = period_to.end_of_month
  end
end
