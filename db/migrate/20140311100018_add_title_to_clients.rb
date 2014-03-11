class AddTitleToClients < ActiveRecord::Migration
  def change
    add_column :clients, :title, :string
  end
end
