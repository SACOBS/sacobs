class DropAddresses < ActiveRecord::Migration
  def change
    drop_table :addresses if table_exists?(:addresses)
  end
end
