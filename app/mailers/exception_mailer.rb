class ExceptionMailer < ActionMailer::Base
  default from: "exceptions@sacobs.herokuapp.com"

  def notify(exception)
    @exception = exception
    mail(
        to: 'support@searleconsulting.co.za',
        subject: 'Sacobs Error'
    )
  end
end
