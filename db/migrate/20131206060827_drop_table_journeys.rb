class DropTableJourneys < ActiveRecord::Migration
  def change
    drop_table :journeys
  end
end
