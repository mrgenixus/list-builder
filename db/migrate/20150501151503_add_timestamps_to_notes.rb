class AddTimestampsToNotes < ActiveRecord::Migration
  def change
    change_table(:notes) { |t| t.timestamps }
  end
end
