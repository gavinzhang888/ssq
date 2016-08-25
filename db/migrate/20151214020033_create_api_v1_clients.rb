class CreateApiV1Clients < ActiveRecord::Migration
  def change
    create_table :api_v1_clients do |t|
      t.string :name
      t.integer :category_id
      t.string :phone
      t.string :email
      t.string :address
      t.string :remark

      t.timestamps null: false
    end
  end
end
