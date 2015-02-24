class AddPeriodToReports < ActiveRecord::Migration
  def change
    add_column :reports, :period, :integer, default: 3
  end
end
