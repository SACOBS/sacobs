class ExceptionMailer < ActionMailer::Base
  default from: "exceptions@sacobs.herokuapp.com"

  def notify(exception_name, message, backtrace)
    @exception_name = exception_name
    @message = message
    @backtrace = backtrace
    mail(
      to:      "support@searleconsulting.co.za",
      subject: "Sacobs Error"
    )
  end
end
