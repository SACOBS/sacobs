class RemoveArriveAndDepartFromStops < ActiveRecord::Migration
  def change
    remove_columns :stops, :arrive, :depart
  end
end
