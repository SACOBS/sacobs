class AddBankToClients < ActiveRecord::Migration
  class Bank < ActiveRecord::Base
  end

  def change
    add_column :clients, :bank, :string
    Client.find_each {|client| client.update!(bank: Bank.find(client.bank_id).name)}
  end
end
