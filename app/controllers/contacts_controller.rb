class ContactsController < ApplicationController
  params_for :contact, :name, :email, :message, :nickname

  def new
    @contact = build_contact
  end

  def create
    @contact = build_contact
    if @contact.valid?
      ContactMailer.delay.contact_us(@contact)
      flash[:notice] = "Thank you for your message. We will get back to you as soon as possible."
      redirect_to root_path
    else
      flash.now[:alert] = 'There was a problem sending your mail. Please try again.'
      render :new
    end
  end

  private
  def build_contact
    Contact.new(contact_params)
  end
end