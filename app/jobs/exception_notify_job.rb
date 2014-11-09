class ExceptionNotifyJob
  include SuckerPunch::Job

  def perform(exception_name, message, backtrace)
    ExceptionMailer.notify(exception_name, message, backtrace).deliver
  end
end
