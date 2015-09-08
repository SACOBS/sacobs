class AddDailyToReports < ActiveRecord::Migration
  def change
    add_column :reports, :daily, :boolean, default: false
  end
end
