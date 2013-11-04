class AddSlugToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :slug, :string
    add_index :drivers, :slug, unique: true
  end
end
