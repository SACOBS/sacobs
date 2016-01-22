# == Schema Information
#
# Table name: rosters
#
#  id         :integer          not null, primary key
#  driver_id  :integer
#  trip_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Roster < ActiveRecord::Base
  belongs_to :driver
  belongs_to :trip
end
