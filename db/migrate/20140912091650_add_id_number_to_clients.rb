class AddIdNumberToClients < ActiveRecord::Migration
  def change
    add_column :clients, :id_number, :string
  end
end
