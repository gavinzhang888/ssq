class CreateUserViews < ActiveRecord::Migration[5.0]
  def change
    create_table :user_views do |t|
      t.references :user, index: true
      t.string :list_type
      t.string :name
      t.boolean :is_default, default: false
      t.text :detail

      t.datetime :deleted_at

      t.timestamps
    end
  end
end