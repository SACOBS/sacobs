class AddTripSheetNotesToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :trip_sheet_note1, :string
    add_column :settings, :trip_sheet_note2, :string
    add_column :settings, :trip_sheet_note3, :string
    add_column :settings, :trip_sheet_note4, :string
  end
end
