class Contact
  include ActiveModel::Model

  VALID_EMAIL_REGEX = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i

  attr_accessor :name, :email, :message, :nickname

  validates :name, :email, :message, presence: true
  validates :email, format: {with: VALID_EMAIL_REGEX}
  validates :message, length: {maximum: 300}
  validates :nickname, absence: true
end
