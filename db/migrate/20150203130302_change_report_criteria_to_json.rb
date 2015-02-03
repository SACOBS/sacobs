class ChangeReportCriteriaToJson < ActiveRecord::Migration
  def change
    remove_column :reports, :criteria

    add_column :reports, :criteria, :json, null: false, default: {}
  end
end
