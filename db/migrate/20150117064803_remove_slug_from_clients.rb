class RemoveSlugFromClients < ActiveRecord::Migration
  def change
    remove_column :clients, :slug
  end
end
