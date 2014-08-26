
class ApplicationController < ActionController::Base
  include Pundit

  self.responder = ApplicationResponder
  respond_to :html,:js,:json,:pdf

  before_action :authenticate_user!
  after_action :prepare_unobtrusive_flash, except: :destroy

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :has_layout?

  etag { current_user.try :id }



  def settings
    @settings ||= Setting.first
  end
  helper_method :settings

  private
    def has_layout?
     false if request.xhr?
    end

  protected
    def devise_parameter_sanitizer
      UserSanitizer.new(User, :user, params)
    end
end
