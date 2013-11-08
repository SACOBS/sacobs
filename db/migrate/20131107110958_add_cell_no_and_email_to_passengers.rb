class AddCellNoAndEmailToPassengers < ActiveRecord::Migration
  def change
    add_column :passengers, :cell_no, :string
    add_column :passengers, :email, :string
  end
end
