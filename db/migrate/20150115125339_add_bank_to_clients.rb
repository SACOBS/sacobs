class AddBankToClients < ActiveRecord::Migration
  class Bank < ActiveRecord::Base
  end

  def change
    add_column :clients, :bank, :string
    Client.all.each {|client| client.update(bank: Bank.find(bank.id).name)}
  end
end
