class AddReferenceNoToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :reference_no, :string
  end
end
