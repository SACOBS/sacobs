class RemoveSlugFromCities < ActiveRecord::Migration
  def change
    remove_column :cities, :slug
  end
end
