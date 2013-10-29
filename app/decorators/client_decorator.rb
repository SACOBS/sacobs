class ClientDecorator < ApplicationDecorator

  attr_reader :client

  def initialize(client)
    @client = client
  end

  def telephone
    client.cell_no ? h.number_to_phone(client.tel_no) : 'None'
  end

  def cellphone
    client.cell_no ? h.number_to_phone(client.cell_no) : 'None'
  end

  def email
    client.email ? h.mail_to(client.email) : 'None'
  end

  def to_s
    client
  end

  def to_param
    client.to_param
  end

  def method_missing(method_name, *args, &block)
    client.send(method_name, *args, &block)
  end

  def respond_to_missing?(method_name, include_private = false)
    client.respond_to?(method_name, include_private) || super
  end
end