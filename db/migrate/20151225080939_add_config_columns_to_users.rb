class AddConfigColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :boxed, :boolean, default: false
    add_column :users, :collapsed, :boolean, default: false
    add_column :users, :floated, :boolean, default: false
    add_column :users, :hovered, :boolean, default: false
  end
end
