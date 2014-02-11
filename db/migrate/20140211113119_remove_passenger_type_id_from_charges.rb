class RemovePassengerTypeIdFromCharges < ActiveRecord::Migration
  def change
    remove_column :charges, :passenger_type_id
    add_column :charges, :description, :string
  end
end
