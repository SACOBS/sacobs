class AddPeriodFromPeriodToToReports < ActiveRecord::Migration
  def change
    add_column :reports, :period_from, :date
    add_column :reports, :period_to, :date
  end
end
