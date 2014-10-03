class SettingsController < ApplicationController
  before_action :set_setting

  def edit; end

  def update
    @setting.update(setting_params)
    respond_with @setting, location: setting_url
  end

  private

  def set_setting
    @setting = Setting.first_or_create
  end

  def setting_params
    SettingParameters.new(params).permit
  end
end
