class AddBankIdToClients < ActiveRecord::Migration
  def change
    add_column :clients, :bank_id, :integer
  end
end
