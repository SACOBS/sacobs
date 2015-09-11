class RemoveIndexUserIdFromVouchers < ActiveRecord::Migration
  def change
    remove_index :vouchers, :user_id
  end
end
