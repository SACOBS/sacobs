class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  self.responder = ApplicationResponder
  respond_to :html, :js, :json, :pdf, :xls

  before_action :authenticate_user!, :common_settings

  layout :layout_required?

  etag { [current_user.try(:id), flash] }

  def context
    controller_path.delete('/')
  end
  helper_method :context

  def notes
    Note.for_context(context).all
  end
  helper_method :notes

  protected

  def devise_parameter_sanitizer
    UserSanitizer.new(User, :user, params)
  end

  def layout_required?
    false if request.xhr?
  end

  def common_settings
    @settings = Rails.cache.fetch(:common_app_settings, expires_in: 30.days) do
      Setting.first_or_create
    end
  end
end
