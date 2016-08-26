class CreatePrizeBalls < ActiveRecord::Migration[5.0]
  def change
    create_table :prize_balls do |t|
      t.integer :number
      t.datetime :date
      t.integer :red_1
      t.integer :red_2
      t.integer :red_3
      t.integer :red_4
      t.integer :red_5
      t.integer :red_6
      t.integer :blue
      t.integer :all_count, default: 0
      t.decimal :amount, precision: 30, scale: 2, default: 0
      t.integer :grade_1, default: 0
      t.decimal :amount_1, precision: 30, scale: 2, default: 0
      t.integer :grade_2, default: 0
      t.decimal :amount_2, precision: 30, scale: 2, default: 0
      t.integer :grade_3, default: 0
      t.decimal :amount_3, precision: 30, scale: 2, default: 0
      t.integer :grade_4, default: 0
      t.decimal :amount_4, precision: 30, scale: 2, default: 0
      t.integer :grade_5, default: 0
      t.decimal :amount_5, precision: 30, scale: 2, default: 0
      t.integer :grade_6, default: 0
      t.decimal :amount_6, precision: 30, scale: 2, default: 0
      t.integer :odd, default: 0
      t.integer :prime, default: 0
      t.integer :red_total, default: 0
      t.integer :total, default: 0
      t.integer :week_number

      t.references :creator, index: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
