class AddSeqToBookingsSequenceId < ActiveRecord::Migration
  def up
    execute <<-SQL
      ALTER SEQUENCE sequence_id_seq OWNED BY bookings.sequence_id;
      ALTER TABLE bookings ALTER COLUMN sequence_id SET DEFAULT nextval('sequence_id_seq');
    SQL
  end

  def down
    execute <<-SQL
      ALTER SEQUENCE sequence_id_seq OWNED BY NONE;
      ALTER TABLE bookings ALTER COLUMN sequence_id SET NOT NULL;
    SQL
  end
end
