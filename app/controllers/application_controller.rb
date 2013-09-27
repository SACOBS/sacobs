require "application_responder"

class ApplicationController < ActionController::Base
  include ParamsFor
  self.responder = ApplicationResponder
  respond_to :html,:js,:json

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_up_path_for(resource)
    root_path
  end
end
