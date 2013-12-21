class RemoveFromCityIdAndToCityIdFromConnections < ActiveRecord::Migration
  def change
    remove_columns :connections, :from_city_id, :to_city_id
  end
end
