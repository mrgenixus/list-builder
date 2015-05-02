class AddIncomingMessageEmailToList < ActiveRecord::Migration
  def change
    add_column :lists, :incoming_message_email, :string
  end
end
