class AddUserIdToSeasonalMarkups < ActiveRecord::Migration
  def change
    add_column :seasonal_markups, :user_id, :integer
  end
end
