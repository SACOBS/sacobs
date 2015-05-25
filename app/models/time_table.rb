# == Schema Information
#
# Table name: time_tables
#
#  id         :integer          not null, primary key
#  arrive     :time
#  depart     :time
#  direction  :integer          default(0)
#  city_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_time_tables_on_city_id  (city_id)
#

class TimeTable < ActiveRecord::Base
  belongs_to :city, touch: true

  enum direction: [:outgoing, :incoming]

  validates :direction, :arrive, :depart, presence: true
end
