class AddTicketInstructionsToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :ticket_instructions, :string
  end
end
