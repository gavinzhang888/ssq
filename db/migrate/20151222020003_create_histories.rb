class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :historyable_type
      t.integer :historyable_id
      t.references :user, index: true
      t.string :operation
      t.text :detail

      t.timestamps
    end
    add_index :histories, [:historyable_id, :historyable_type]
  end
end
