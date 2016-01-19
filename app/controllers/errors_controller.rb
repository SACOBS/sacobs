class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_exception, :send_error_notification

  def show
    respond_to do |format|
      format.html { render action: request.path[1..-1] }
      format.json { render json: {status: request.path[1..-1], error: @exception.message} }
    end
  end

  private

  def set_exception
    @exception = env["action_dispatch.exception"]
  end

  def send_error_notification
    return unless internal_server_error?
    exception_name = @exception.class.to_s
    message = @exception.message
    backtrace = ActionDispatch::ExceptionWrapper.new(env, @exception).application_trace.join("\n")
    ExceptionMailer.notify(exception_name, message, backtrace).deliver_later
  end

  def internal_server_error?
    ActionDispatch::ExceptionWrapper.status_code_for_exception(@exception.class.name) == Rack::Utils::SYMBOL_TO_STATUS_CODE[:internal_server_error]
  end
  end
