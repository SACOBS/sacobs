class AddChargesToPassenger < ActiveRecord::Migration
  def change
    add_column :passengers, :charges, :integer, array:true, default:[]
  end
end
