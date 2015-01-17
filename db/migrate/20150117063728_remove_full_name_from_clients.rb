class RemoveFullNameFromClients < ActiveRecord::Migration
  def change
    remove_column :clients, :full_name
  end
end
