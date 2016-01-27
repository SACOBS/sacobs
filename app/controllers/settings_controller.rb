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
#  email                 :string
#

class SettingsController < ApplicationController
  def edit; end

  def update
    settings.update(setting_params)
    respond_with(settings, location: settings_url)
  end

  private

  def setting_params
    params.fetch(:setting).permit(:booking_expiry_period,
                                      :email,
                                      :ticket_instructions,
                                      :default_scripture,
                                      :trip_sheet_note1,
                                      :trip_sheet_note2,
                                      :trip_sheet_note3,
                                      :trip_sheet_note4
                                     )
  end
end
