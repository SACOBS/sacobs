module ValidationsHelper
  VALID_EMAILS =  %w(niceandsimple@example.com very.common@example.com a.little.lengthy.but.fine@dept.example.com)

  def valid_emails
    VALID_EMAILS.join(',')
  end
end