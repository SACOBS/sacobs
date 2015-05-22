class AddIndexToSequenceDestinations < ActiveRecord::Migration
  def change
    add_index :destinations, :sequence
  end
end
