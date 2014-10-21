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
  before_action :set_notes
  after_action :prepare_unobtrusive_flash, except: :destroy

  etag { current_user.try :id }

  def current_user
    super || NullUser.new
  end

  private

  def set_notes
    context = controller_path.gsub('/', '')
    @notes = Note.for_context(context)
  end

  protected

  def devise_parameter_sanitizer
    UserSanitizer.new(User, :user, params)
  end
end
