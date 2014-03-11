# == Schema Information
#
# Table name: settings
#
#  id                    :integer          not null, primary key
#  booking_expiry_period :integer
#  created_at            :datetime
#  updated_at            :datetime
#  ticket_instructions   :string(255)
#  default_scripture     :string(255)
#  trip_sheet_note1      :string(255)
#  trip_sheet_note2      :string(255)
#  trip_sheet_note3      :string(255)
#  trip_sheet_note4      :string(255)
#

require 'spec_helper'

describe Setting do
  pending "add some examples to (or delete) #{__FILE__}"
end
