class ApplicationMailer < ActionMailer::Base
  helper :application

  def settings
    @settings ||= Rails.cache.fetch(:common_app_settings, expires_in: 30.days) do
      Setting.first_or_create
    end
  end
  helper_method :settings

end
