class SettingsController < ApplicationController
  before_action :set_setting

  def edit; end

  def update
    @setting.update(setting_params)
    redirect_to setting_url
  end

  private

  def set_setting
    @setting = Setting.first_or_create
  end

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
