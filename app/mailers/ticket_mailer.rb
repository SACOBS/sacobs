class TicketMailer < ActionMailer::Base
  helper :bootstrap, :application

  before_action :common_settings

  def send_ticket(booking)
    @ticket = Ticket.new(booking, view_context, @settings)
    mail to: booking.client.email, cc: @settings.email, from: @settings.email, subject: 'Your Ticket'
  end

  private

  def common_settings
    @settings = Rails.cache.fetch(:common_app_settings, expires_in: 30.days) do
      Setting.first_or_create
    end
  end
end
