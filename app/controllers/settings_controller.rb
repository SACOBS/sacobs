class SettingsController < ApplicationController
  def edit; end

  def update
    @settings.update(setting_params)
    respond_with(@settings, location: settings_url)
  end

  private

  def setting_params
    params.fetch(:setting, {}).permit(:booking_expiry_period,
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
