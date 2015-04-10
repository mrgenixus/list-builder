class RemoveNotesFromPerson < ActiveRecord::Migration
  def change
    remove_column :people, :notes
  end
end
