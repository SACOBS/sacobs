class AddBankToClients < ActiveRecord::Migration
  class Bank < ActiveRecord::Base
  end

  def change
    add_column :clients, :bank, :string
    Client.find_each do |client|
      client.bank = Bank.find_by(id: client.bank_id).try(:name)
      client.save(validate: false)
    end
  end
end
