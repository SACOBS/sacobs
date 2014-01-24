class RenameFromAndToOnSeasonalMarkups < ActiveRecord::Migration
  def change
    rename_column :seasonal_markups, :from, :period_from
    rename_column :seasonal_markups, :to, :period_to
  end
end
