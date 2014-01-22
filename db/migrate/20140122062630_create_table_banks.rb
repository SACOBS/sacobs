class CreateTableBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :name
    end
  end
end
