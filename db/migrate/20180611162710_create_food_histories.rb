class CreateFoodHistories < ActiveRecord::Migration[4.2]
  def change
    create_table :food_histories do |t|
      t.integer :user_id
      t.integer :food_id
      t.timestamps
    end
  end
end
