class RemovePeriodFromReports < ActiveRecord::Migration
  def change
    remove_column :reports, :period
  end
end
