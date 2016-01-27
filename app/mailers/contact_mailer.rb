class ContactMailer < ApplicationMailer
  default from: 'contact@sacobs.com'

  def contact_us(name, email, message)
    @contact = Contact.new(name: name, email: email, message: message)
    mail(
      to:      @contact.email,
      subject: @contact.name
    )
  end
end
