class CreateApiV1Opportunities < ActiveRecord::Migration
  def change
    create_table :api_v1_opportunities do |t|
      t.string :code
      t.string :name
      t.integer :client_id
      t.decimal :amount, precision: 12, scale: 2
      t.string :remark
      t.integer :status_id
      t.integer :creator_id
      t.datetime :deleted_at

      t.timestamps null: false
    end
  end
end
