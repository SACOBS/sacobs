class ContactsController < ApplicationController

  skip_before_action :authenticate_user!



  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.valid?
      ContactMailJob.new.async.perform(@contact)
      flash[:notice] = "Thank you for your message. We will get back to you as soon as possible."
      redirect_to root_path
    else
      flash.now[:alert] = 'There was a problem sending your mail. Please try again.'
      render :new
    end
  end

  private
    def contact_params
      ContactParameters.new(params).permit
    end
end