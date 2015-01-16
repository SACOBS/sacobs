class AddUniqueIndexToClientName < ActiveRecord::Migration
  def change
    add_index :clients, [:name, :surname] ,unique: true
  end
end
