class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :content
      t.references :membership, index: true
    end
    add_foreign_key :notes, :memberships
  end
end
