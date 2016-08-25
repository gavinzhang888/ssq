class AddCreatorIdToApiV1Clients < ActiveRecord::Migration
  def change
    add_column :api_v1_clients, :creator_id, :integer
  end
end
