class AddVenuesCountToCities < ActiveRecord::Migration
  def change
    add_column :cities, :venues_count, :integer, default: 0

    City.find_each(select: :id) do |result|
      City.reset_counters(result.id, :venues)
    end
  end
end
