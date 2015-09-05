class AddDefaultValuesForRowAndNumberForSeats < ActiveRecord::Migration
  def change
    change_column_default :seats, :row, 'A-Z'
    change_column_default :seats, :number, '0'
  end
end
