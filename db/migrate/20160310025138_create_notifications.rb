class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, index: true
      t.text :content
      t.string :link
      t.boolean :readed, default: false
      t.integer :category

      t.references :creator, index: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end