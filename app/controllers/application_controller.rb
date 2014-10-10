class ApplicationController < ActionController::Base
  include JavascriptClassName
  include LayoutRequired
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  self.responder = ApplicationResponder
  respond_to :html, :js, :json, :pdf

  before_action :authenticate_user!
  after_action :prepare_unobtrusive_flash, except: :destroy

  etag { current_user.try :id }

  protected

  def devise_parameter_sanitizer
    UserSanitizer.new(User, :user, params)
  end
end
