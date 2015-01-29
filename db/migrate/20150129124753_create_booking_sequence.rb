class CreateBookingSequence < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE SEQUENCE sequence_id_seq;
    SQL
  end

  def down
    execute <<-SQL
      DROP SEQUENCE sequence_id_seq;
    SQL
  end
end
