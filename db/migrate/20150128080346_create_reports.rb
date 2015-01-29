class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :name, null: false
      t.hstore :criteria, default: {}, null: false
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
