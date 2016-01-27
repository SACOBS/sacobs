class Auxiliary < ActiveRecord::Migration
  def self.up
    execute 'TRUNCATE schema_migrations;'
    execute "INSERT INTO schema_migrations VALUES ('20151009194636');"
  end

  def self.down
    fail ActiveRecord::IrreversibleMigration
  end
end
