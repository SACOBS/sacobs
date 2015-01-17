class RemoveSlugFromRoutes < ActiveRecord::Migration
  def change
    remove_column :routes, :slug
  end
end
