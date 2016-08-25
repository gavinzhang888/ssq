class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :name
      t.integer :sort_num
      t.string :type

      t.timestamps null: false
    end
  end
end
