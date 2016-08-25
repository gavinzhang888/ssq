class AddConfigColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :locale, :string, :defaults => "zh-CN"
    add_column :users, :theme, :string, :defaults => "theme-a"
  end
end
