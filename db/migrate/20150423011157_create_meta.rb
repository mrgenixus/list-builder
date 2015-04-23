class CreateMeta < ActiveRecord::Migration
  def change
    create_table :meta do |t|
      t.string :key
      t.text :value
      t.references :membership, index: true
    end
    add_foreign_key :meta, :memberships
  end
end
