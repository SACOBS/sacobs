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

  def current_user
    super || NullUser.new
  end

  def context
    controller_path.gsub('/', '')
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
end
