class ContactMailJob
  include SuckerPunch::Job

  def perform(contact)
    @contact = contact
    ContactMailer.contact_us(@contact).deliver
  end
end
