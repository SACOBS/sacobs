class AddWorkNoAndChangeTelNoToHomeNumberOnClients < ActiveRecord::Migration
  def change
    add_column :clients, :work_no, :string
    rename_column :clients, :tel_no, :home_no
  end
end
