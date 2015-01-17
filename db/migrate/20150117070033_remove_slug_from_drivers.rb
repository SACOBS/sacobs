class RemoveSlugFromDrivers < ActiveRecord::Migration
  def change
    remove_column :drivers, :slug
  end
end
