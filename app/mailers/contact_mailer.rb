class ContactMailer < ActionMailer::Base
  default from: "from@example.com"

  def contact_us(info)
    @info = info
    mail(
        to: 'info@saconnection.co.za',
        subject: info.name,
        from: 'Sacob'
    )
  end
end
