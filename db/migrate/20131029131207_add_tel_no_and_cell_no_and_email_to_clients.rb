class AddTelNoAndCellNoAndEmailToClients < ActiveRecord::Migration
  def change
    add_column :clients, :tel_no, :string
    add_column :clients, :cell_no, :string
    add_column :clients, :email, :string
  end
end
