class CreateSeasonalMarkups < ActiveRecord::Migration
  def change
    create_table :seasonal_markups do |t|
      t.decimal :percentage
      t.date :from
      t.date :to
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
