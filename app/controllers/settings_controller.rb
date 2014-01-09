class SettingsController < ApplicationController

  before_action :set_setting

  params_for :setting, :booking_expiry_period

  def edit

  end

  def update
    @setting.update(setting_params)
    respond_with @setting, location: setting_url
  end

  private
    def set_setting
      @setting = Setting.first_or_create
    end
end