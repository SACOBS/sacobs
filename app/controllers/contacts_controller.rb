class ContactsController < ApplicationController

  before_action :build_contact

  def new;end

  def create
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
      @contact = Contact.new
    end

    def contact_params
      ContactParameters.new(params).permit
    end
end