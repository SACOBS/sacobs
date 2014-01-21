class AddHighRiskFlagToClients < ActiveRecord::Migration
  def change
    add_column :clients, :high_risk, :boolean, default: false
  end
end
