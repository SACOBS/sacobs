class ChangeArriveAndDepartToTime < ActiveRecord::Migration
  def change
    change_column :stops, :arrive, :time
    change_column :stops, :depart, :time
  end
end
