class AddUserIdToBuses < ActiveRecord::Migration
  def change
    add_column :buses, :user_id, :integer
  end
end
