class AddMissingIndexes3 < ActiveRecord::Migration
  def change
    add_index :payment_details, :payment_type_id
    add_index :charges, :user_id
  end
end
