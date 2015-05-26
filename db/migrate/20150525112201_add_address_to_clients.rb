class AddAddressToClients < ActiveRecord::Migration
  def change
    add_column :clients, :street_address1, :string
    add_column :clients, :street_address2, :string
    add_column :clients, :city, :string
    add_column :clients, :postal_code, :string

    update_clients
  end

  private
  def update_clients
    transaction do
      Address.all.each do |address|
        client = address.addressable
        client.street_address1 = address.street_address1
        client.street_address2 = address.street_address2
        client.city = address.city
        client.postal_code = address.postal_code
        client.save!
      end
    end
  end

  class Address < ActiveRecord::Base
    belongs_to :addressable, polymorphic: true
  end
end
