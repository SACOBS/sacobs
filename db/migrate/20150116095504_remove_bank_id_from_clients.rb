class RemoveBankIdFromClients < ActiveRecord::Migration
  def change
    remove_column :clients, :bank_id
  end
end
