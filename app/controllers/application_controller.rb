require "application_responder"

class ApplicationController < ActionController::Base
  include ParamsFor
  self.responder = ApplicationResponder
  respond_to :html,:js,:json, :pdf

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :has_layout?


  def settings
    @settings ||= Setting.first
  end
  helper_method :settings

  private
    def after_sign_in_path_for(resource)
      root_path
    end

    def after_sign_up_path_for(resource)
      root_path
    end

    def user
      { user: current_user }
    end

    def has_layout?
     false if request.xhr?
    end

  protected
    def devise_parameter_sanitizer
      UserSanitizer.new(User, :user, params)
    end
end
