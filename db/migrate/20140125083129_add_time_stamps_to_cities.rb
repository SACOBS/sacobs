class AddTimeStampsToCities < ActiveRecord::Migration
  def change
    add_timestamps(:cities)
  end
end
