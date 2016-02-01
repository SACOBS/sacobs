class AddUniqeIndexOnChargeDescription < ActiveRecord::Migration
  def change
        add_index :charges, :description, unique: true
  end
end
