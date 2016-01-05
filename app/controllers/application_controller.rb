class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  self.responder = ApplicationResponder
  respond_to :html, :js, :json, :pdf, :xls

  before_action :authenticate_user!, :check_rack_mini_profiler, :settings

  layout :layout_required?

  etag { [current_user.try(:id), flash] }

  protected

  def check_rack_mini_profiler
    if current_user&.admin? && params[:rmp].present?
      Rack::MiniProfiler.authorize_request
    end
  end

  def devise_parameter_sanitizer
    UserSanitizer.new(User, :user, params)
  end

  def layout_required?
    false if request.xhr?
  end

  def settings
    @settings ||= Rails.cache.fetch(:common_app_settings, expires_in: 30.days) do
      Setting.first_or_create
    end
  end
end
