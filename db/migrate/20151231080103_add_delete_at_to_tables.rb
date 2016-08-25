class AddDeleteAtToTables < ActiveRecord::Migration
  def change
    add_column :api_v1_clients, :deleted_at, :datetime
    add_column :users, :deleted_at, :datetime
  end
end
