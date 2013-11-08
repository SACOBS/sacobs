class AddSlugToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :slug, :string
    add_index :routes, :slug, unique: true
  end
end
