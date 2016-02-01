class AddUniqeIndexOnPassengerTypeDescription < ActiveRecord::Migration
  def change
    add_index :passenger_types, :description, unique: true
  end
end
