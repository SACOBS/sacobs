class ChangeBookingStatusToInteger < ActiveRecord::Migration
  def change
    change_column :bookings, :status, 'integer USING CAST(status AS integer)'
  end
end
