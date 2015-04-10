class CreateMembership < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :list, index: true
      t.references :person, index: true
    end
    add_foreign_key :memberships, :lists
    add_foreign_key :memberships, :people
  end
end
