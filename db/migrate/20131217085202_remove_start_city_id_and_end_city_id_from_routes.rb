class RemoveStartCityIdAndEndCityIdFromRoutes < ActiveRecord::Migration
  def change
    remove_columns :routes, :start_city_id, :end_city_id
  end
end
