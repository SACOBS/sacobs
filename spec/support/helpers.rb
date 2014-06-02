module Helpers
  module Validations
     VALID_EMAILS =  %w(niceandsimple@example.com very.common@example.com a.little.lengthy.but.fine@dept.example.com).freeze
     INVALID_EMAILS = %w(@example.com Joe Smith <email@example.com> email.example.com email@example@example.com).freeze

     def valid_email_address
       VALID_EMAILS.sample
     end

     def invalid_email_address
       INVALID_EMAILS.sample
     end
  end
end