class MailInterceptor
  def self.delivering_email(message)
    message.to = ['paul@searleconsuling.co.za']
  end
end

if Rails.env.development?
  ActionMailer::Base.register_interceptor(MailInterceptor)
end
