# == Schema Information
#
# Table name: settings
#
#  id                    :integer          not null, primary key
#  booking_expiry_period :integer
#  created_at            :timestamp withou
#  updated_at            :timestamp withou
#  ticket_instructions   :character varyin
#  default_scripture     :character varyin
#  trip_sheet_note1      :character varyin
#  trip_sheet_note2      :character varyin
#  trip_sheet_note3      :character varyin
#  trip_sheet_note4      :character varyin
#  email                 :character varyin
#

class Setting < ActiveRecord::Base

end
