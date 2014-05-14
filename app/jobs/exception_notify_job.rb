class ExceptionNotifyJob
  include SuckerPunch::Job

  def perform(exception)
    @exception = exception
    ExceptionMailer.notify(@exception).deliver
  end
end