class AddInfoToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :birthday, :date
    add_column :users, :weight, :integer
    add_column :users, :height, :integer
    add_column :users, :gender, :integer
    add_column :users, :calorie_of_day, :integer
  end
end
