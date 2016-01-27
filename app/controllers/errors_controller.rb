class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :set_exception
  before_action :send_error_notification, if: :internal_server_error?

  def show
    respond_to do |format|
      format.html { render action: request.path[1..-1] }
      format.json { render json: { status: request.path[1..-1], error: @exception.message } }
    end
  end

  private

  def set_exception
    @exception = env['action_dispatch.exception']
  end

  def backtrace
    ActionDispatch::ExceptionWrapper.new(env, @exception).application_trace.join("\n")
  end

  def status_code
    ActionDispatch::ExceptionWrapper.status_code_for_exception(@exception.class.name)
  end

  def send_error_notification
    exception_name = @exception.class.to_s
    message = @exception.message
    ExceptionMailer.notify(exception_name, message, backtrace).deliver_later
  end

  def internal_server_error?
    status_code == Rack::Utils::SYMBOL_TO_STATUS_CODE[:internal_server_error]
  end
end
