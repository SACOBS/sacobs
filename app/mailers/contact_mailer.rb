class ContactMailer < ActionMailer::Base
  default from: "contact@sacobs.com"

  def contact_us(contact)
    @contact = contact
    mail(
        to: contact.email,
        subject: contact.name,
    )
  end
end
