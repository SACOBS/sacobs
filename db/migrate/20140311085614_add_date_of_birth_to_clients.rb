class AddDateOfBirthToClients < ActiveRecord::Migration
  def change
    add_column :clients, :date_of_birth, :date
  end
end
