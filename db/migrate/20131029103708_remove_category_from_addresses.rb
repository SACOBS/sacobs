class RemoveCategoryFromAddresses < ActiveRecord::Migration
  def change
    remove_column :addresses, :category
  end
end
