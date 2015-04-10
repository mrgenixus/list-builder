class AddDetailFieldsToList < ActiveRecord::Migration
  def change
    add_column :lists, :name, :string
    add_column :lists, :description, :text
  end
end
