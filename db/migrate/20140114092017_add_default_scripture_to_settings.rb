class AddDefaultScriptureToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :default_scripture, :string
  end
end
