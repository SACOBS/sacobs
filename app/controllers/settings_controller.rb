class SettingsController < ApplicationController

  params_for :setting, :key, :value

  def index
   @settings = Setting.all
  end

  def new
   @setting = Setting.new
  end

  def create
   @setting = Setting.create(setting_params)
   respond_with(@setting, location: settings_url)
  end

  def update
    settings_params.keys.each do |id|
      setting = Setting.find(id)
      setting.update(params["settings"][id])
    end
    redirect_to settings_url
  end

  private
    def settings_params
      settings_params = params.require(:settings).permit!
    end
end
