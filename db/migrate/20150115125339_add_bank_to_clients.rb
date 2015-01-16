class AddBankToClients < ActiveRecord::Migration
  def change
    add_column :clients, :bank, :string
  end
end
