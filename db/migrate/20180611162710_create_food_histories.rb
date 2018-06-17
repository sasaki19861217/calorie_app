class CreateFoodHistories < ActiveRecord::Migration
  def change
    create_table :food_histories do |t|
      t.string :title
      t.string :detail

      t.timestamps
    end
  end
end
